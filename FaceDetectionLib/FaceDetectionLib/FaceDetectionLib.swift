//
//  FaceDetectionLib.swift
//  FaceDetectionLib
//
//  Created by Dima Virych on 20.03.2020.
//  Copyright © 2020 Virych. All rights reserved.
//

import Vision
import AVFoundation

public typealias FDFace = VNFaceObservation

public protocol FaceDetectorDelegate: class {
    
    func faceDetector(_ detector: FaceDetector, didDetectFaces faces: [FDFace])
}

public final class FaceDetector: NSObject {
    
    // MARK: - Properties
    
    private let videoDataOutput = AVCaptureVideoDataOutput()
    private let queue = DispatchQueue(label: "camera_frame_processing_queue")
    private let camera: FDCamera
    
    public weak var delegate: FaceDetectorDelegate?
    
    public init(_ camera: FDCamera, delegate: FaceDetectorDelegate? = nil) {
        
        self.camera = camera
        self.delegate = delegate
        
        super.init()
        
        getCameraFrames()
    }
    
    private func getCameraFrames() {
        
        videoDataOutput.videoSettings = [(kCVPixelBufferPixelFormatTypeKey as NSString) : NSNumber(value: kCVPixelFormatType_32BGRA)] as [String : Any]
        videoDataOutput.alwaysDiscardsLateVideoFrames = true
        videoDataOutput.setSampleBufferDelegate(self, queue: queue)
        camera.addOutput(videoDataOutput)
        guard let connection = self.videoDataOutput.connection(with: AVMediaType.video),
            connection.isVideoOrientationSupported else { return }
        connection.videoOrientation = .portrait
    }
    
    private func detectFace(in image: CVPixelBuffer) {
        
        let faceDetectionRequest = VNDetectFaceLandmarksRequest(completionHandler: { (request: VNRequest, error: Error?) in
            DispatchQueue.main.async {
                
                if let results = request.results as? [VNFaceObservation], results.count > 0 {
                    
                    self.delegate?.faceDetector(self, didDetectFaces: results)
                } else {
                    self.delegate?.faceDetector(self, didDetectFaces: [])
                }
            }
        })
        let imageRequestHandler = VNImageRequestHandler(cvPixelBuffer: image, orientation: .leftMirrored, options: [:])
        try? imageRequestHandler.perform([faceDetectionRequest])
    }
}


extension FaceDetector: AVCaptureVideoDataOutputSampleBufferDelegate {
    
    public func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        
        guard let frame = CMSampleBufferGetImageBuffer(sampleBuffer) else {
            debugPrint("unable to get image from sample buffer")
            return
        }
        
        self.detectFace(in: frame)
    }
}

public extension VNFaceLandmarks2D {
    
    var landmarks: [VNFaceLandmarkRegion2D] {
        [leftEye,
         rightEye,
         leftEyebrow,
         rightEyebrow,
         nose,
         outerLips,
         innerLips,
         leftPupil,
         rightPupil].compactMap { $0 }
    }
}
