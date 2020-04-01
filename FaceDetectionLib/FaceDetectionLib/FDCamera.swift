//
//  FDCamera.swift
//  FaceDetectionLib
//
//  Created by Dima Virych on 20.03.2020.
//  Copyright © 2020 Virych. All rights reserved.
//

import AVFoundation
import UIKit

public final class FDCamera {
    
    // MARK: - Properties
    
    private let captureSession = AVCaptureSession()
    
    private lazy var previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
    
    
    // MARK: - Init
    
    public init() throws {
        
        try addCameraInput()
    }
    
    
    // MARK: - Private
    
    private func addCameraInput() throws {
        
        guard let device = AVCaptureDevice.DiscoverySession(
            deviceTypes: [.builtInWideAngleCamera, .builtInDualCamera, .builtInTrueDepthCamera],
            mediaType: .video,
            position: .front).devices.first else {
                fatalError("No camera device found, please make sure to run SimpleLaneDetection in an iOS device and not a simulator")
        }
        
        let cameraInput = try AVCaptureDeviceInput(device: device)
        captureSession.addInput(cameraInput)
    }

    
    // MARK: - Interface
    
    public func attachOutputLayer(to view: UIView) {
        
        previewLayer.videoGravity = .resizeAspectFill
        view.layer.addSublayer(previewLayer)
        previewLayer.frame = view.frame
        
        captureSession.startRunning()
    }
    
    public func updateFrame(_ frame: CGRect) {
        
        previewLayer.frame = frame
    }
    
    public func addOutput(_ output: AVCaptureVideoDataOutput) {
        
        captureSession.addOutput(output)
    }
}
