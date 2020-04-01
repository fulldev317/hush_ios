//
//  FDLib.swift
//  FaceDetectionLib
//
//  Created by Dima Virych on 01.04.2020.
//  Copyright © 2020 Virych. All rights reserved.
//

import Foundation
import ARKit
import CoreGraphics
import Vision

public protocol FDLibDelegate: class {
    
    func faceDetector(_ detector: FDLib, didDetectFaces faces: [FDFace])
}

public final class FDLib: NSObject {
    
    // MARK: - Properties
    
    public weak var delegate: FDLibDelegate?
    
    private var scanTimer: Timer?
    private var sceneView: ARSCNView!
    private var imageOrientation: CGImagePropertyOrientation {
        switch UIDevice.current.orientation {
        case .portrait: return .right
        case .landscapeRight: return .down
        case .portraitUpsideDown: return .left
        case .unknown: fallthrough
        case .faceUp: fallthrough
        case .faceDown: fallthrough
        case .landscapeLeft: return .up
        default: return .up
        }
    }
    
    public init(delegate: FDLibDelegate? = nil) {
    
        self.delegate = delegate
        
        super.init()
        
        getCameraFrames()
    }
    
    deinit {
        
        scanTimer?.invalidate()
        sceneView.session.pause()
    }
    
    public func attachOutputLayer(to view: UIView) {
        
        view.addSubview(sceneView)
        sceneView.frame = view.frame
        
        let configuration = ARFaceTrackingConfiguration()
        sceneView.session.run(configuration)
        scanTimer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(scanForFaces), userInfo: nil, repeats: true)
    }
    
    private func getCameraFrames() {
        
        sceneView = ARSCNView(frame: .zero)
    }
    
    private func detectFace(in image: CIImage) {
        
        let faceDetectionRequest = VNDetectFaceLandmarksRequest(completionHandler: { (request: VNRequest, error: Error?) in
            DispatchQueue.main.async {
                
                if let results = request.results as? [VNFaceObservation], results.count > 0 {
                    
                    self.delegate?.faceDetector(self, didDetectFaces: results)
                } else {
                    self.delegate?.faceDetector(self, didDetectFaces: [])
                }
            }
        })
        let imageRequestHandler = VNImageRequestHandler(ciImage: image, orientation: .leftMirrored, options: [:])
        try? imageRequestHandler.perform([faceDetectionRequest])
    }
    
    @objc private func scanForFaces() {
        
        guard let capturedImage = sceneView.session.currentFrame?.capturedImage else { return }
        let image = CIImage(cvPixelBuffer: capturedImage)
        detectFace(in: image)
    }
}
