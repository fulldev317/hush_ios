//
//  DVImagePicker.swift
//  AppForType
//
//  Created by Dmitriy Virych on 6/22/17.
//  Copyright © 2017 Virych. All rights reserved.
//

import Foundation
import UIKit
import Photos

class DVImagePicker: NSObject {
    
    enum Result {
        
        case failure
        case success(UIImage)
    }
    
    func showActionSheet(from vc: UIViewController, result: @escaping (Result) -> Void) {
        
        let alertController = UIAlertController(title: "Choose image", message: nil, preferredStyle: .actionSheet)
        
        alertController.addAction(UIAlertAction(title: "Take a Photo", style: .default) { [weak self] _ in
            self?.showController(with: .camera, from: vc, result: result)
        })
        alertController.addAction(UIAlertAction(title: "Camera Roll", style: .default) { [weak self] _ in
            self?.showController(with: .photoLibrary, from: vc, result: result)
        })
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        self.viewController = vc
        self.result = result
        viewController?.present(alertController, animated: true)
    }
    
    
    // MARK: Properties
    
    private var picker: UIImagePickerController = UIImagePickerController()
    private var viewController: UIViewController!
    private var sourceType:  UIImagePickerController.SourceType!
    private var result: ((Result) -> Void)!
    
    
    // MARK: Actions
    
    private func showController(with type:  UIImagePickerController.SourceType, from vc: UIViewController, result: (Result) -> Void) {
        
        sourceType = type
        
        picker.allowsEditing = false
        picker.sourceType = type
        
        if type == .camera {
            picker.cameraCaptureMode = .photo
            picker.showsCameraControls = true
        } else {
            picker.navigationBar.isHidden = true
            picker.navigationBar.barTintColor = .white
        }
        
        picker.delegate = self
        picker.modalPresentationStyle = .overFullScreen
        
        checkMediaAccess(type: type, from: vc)
    }
    
    private func checkMediaAccess(type: UIImagePickerController.SourceType, from vc: UIViewController) {
    
        if type == .camera {
            
            if AVCaptureDevice.authorizationStatus(for: .video) ==  AVAuthorizationStatus.denied {
                AVCaptureDevice.requestAccess(for: .video) { [weak self] (allowed) in
                    if allowed {
                        self?.showPicker(vc)
                    } else {
                        self?.result(.failure)
                    }
                }
            }
            else {
                showPicker(vc)
            }
            
        } else {
            
            if PHPhotoLibrary.authorizationStatus() == .denied || PHPhotoLibrary.authorizationStatus() == .notDetermined {
                
                PHPhotoLibrary.requestAuthorization { [weak self] (status) in
                    switch status {
                    case .authorized: self?.showPicker(vc)
                    default: self?.result(.failure)
                    }
                }
            }
            else {
                showPicker(vc)
            }
        }
    }
    
    private func showPicker(_ vc: UIViewController) {
        
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            vc.present(self.picker, animated: true)
        }
    }
}


// MARK: UIImagePickerControllerDelegate, UINavigationControllerDelegate

extension DVImagePicker: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        
        picker.setNavigationBarHidden(true, animated: false)
        picker.dismiss(animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let image = info[.originalImage] as? UIImage {
            result(.success(image))
        } else {
            result(.failure)
        }
        
        picker.setNavigationBarHidden(true, animated: false)
        
        picker.dismiss(animated: true)
    }
}

