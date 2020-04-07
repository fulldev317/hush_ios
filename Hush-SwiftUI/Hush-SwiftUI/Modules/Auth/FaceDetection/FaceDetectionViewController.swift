//
//  FaceDetectionViewController.swift
//  Hush-SwiftUI
//
//  Created by Dima Virych on 01.04.2020.
//  Copyright © 2020 AppServices. All rights reserved.
//

import FaceDetectionLib
import UIKit
import AVFoundation
import Vision
import SwiftUI

class MainVC: UIViewController, FaceDetectorDelegate {
    
    private let camera = try! FDCamera()
    
    private var drawings: [CAShapeLayer] = []
    private var detector: FaceDetector?
    
    var selectImage = UIImage()
    var selectProp = #imageLiteral(resourceName: "1")
    var stokeColor = UIColor.gray.cgColor
    var imgViewUser: UIImageView!
    var imgView = UIImageView()
    var selectedMainCategoryTag = 0
    
    private weak var previewLayer: AVCaptureVideoPreviewLayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        camera.attachOutputLayer(to: view)
        camera.updateFrame(view.bounds)
        detector = FaceDetector(camera, delegate: self)
        previewLayer = view.layer.sublayers?.first as? AVCaptureVideoPreviewLayer
        imgViewUser = UIImageView(frame: view.bounds)
    }
    
    private func handleFaceDetectionResults(_ observedFaces: [VNFaceObservation]) {
        
        if observedFaces.isEmpty {
            return clearDrawings()
        }
        
        guard let previewLayer = previewLayer else {
            return
        }
        
        self.clearDrawings()
        let facesBoundingBoxes: [CAShapeLayer] = observedFaces.flatMap({ (observedFace: VNFaceObservation) -> [CAShapeLayer] in
            
            let faceBoundingBoxOnScreen = previewLayer.layerRectConverted(fromMetadataOutputRect: observedFace.boundingBox)
            var newDrawings = [CAShapeLayer]()
            if let landmarks = observedFace.landmarks {
                newDrawings = newDrawings + self.drawFaceFeatures(landmarks, screenBoundingBox: faceBoundingBoxOnScreen)
            }
            return newDrawings
        })
        facesBoundingBoxes.forEach({ faceBoundingBox in self.view.layer.addSublayer(faceBoundingBox) })
        self.drawings = facesBoundingBoxes
    }
    
    private func clearDrawings() {
        self.drawings.forEach({ drawing in drawing.removeFromSuperlayer() })
    }
    
    private func drawFaceFeatures(_ landmarks: VNFaceLandmarks2D, screenBoundingBox: CGRect) -> [CAShapeLayer] {
        var faceFeaturesDrawings: [CAShapeLayer] = []
        
        landmarks.landmarks.forEach {
            let eyeDrawing = self.drawEye($0, screenBoundingBox: screenBoundingBox)
            faceFeaturesDrawings.append(eyeDrawing)
        }
        
        
        
        return faceFeaturesDrawings
    }
   
    private func drawEye(_ eye: VNFaceLandmarkRegion2D, screenBoundingBox: CGRect) -> CAShapeLayer {
        
        let eyePath = CGMutablePath()
        let eyePathPoints = eye.normalizedPoints
            .map({ eyePoint in
                CGPoint(
                    x: eyePoint.y * screenBoundingBox.height + screenBoundingBox.origin.x,
                    y: eyePoint.x * screenBoundingBox.width + screenBoundingBox.origin.y)
            })
        eyePath.addLines(between: eyePathPoints)
        eyePath.closeSubpath()
        let eyeDrawing = CAShapeLayer()
        eyeDrawing.path = eyePath
        eyeDrawing.fillColor = UIColor.clear.cgColor
        eyeDrawing.strokeColor = UIColor.green.cgColor
        
        return eyeDrawing
    }
    
    func faceDetector(_ detector: FaceDetector, didDetectFaces faces: [FDFace]) {
        
//        handleFaceDetectionResults(faces)
//        faces.forEach(addFaceLandmarksToImage(_:))
    }
    
    func addFaceLandmarksToImage(_ face: VNFaceObservation) {
        
        let points = face.landmarks?.leftEye?.normalizedPoints.map({ eyePoint in
            CGPoint(
                x: eyePoint.y * view.bounds.height,
                y: eyePoint.x * view.bounds.width)
        }) ?? []
        
        let leftCenter = points.first!
        
        let transform = CGAffineTransform(scaleX: 1, y: -1).translatedBy(x: 0, y: -imgViewUser.frame.size.height)
        let translate = CGAffineTransform.identity.scaledBy(x: view.frame.size.width, y: view.frame.size.height)
        let facebounds = face.boundingBox.applying(translate).applying(transform)

        print(leftCenter)
        imgView.frame = CGRect.init(x: leftCenter.x, y: leftCenter.y, width: facebounds.size.width, height: facebounds.size.height)

        imgView.contentMode = .scaleAspectFit
        imgView.image = selectProp

        view.addSubview(imgView)
    }
}

struct FaceDetectionViewController: UIViewControllerRepresentable {
    
    var vc: UIViewController = {
        #if targetEnvironment(simulator)
          return UIViewController()
        #else
          return MainVC()
        #endif
    }()
    
    func makeUIViewController(context: Context) -> UIViewController {
        
        vc
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        
        
    }
}
