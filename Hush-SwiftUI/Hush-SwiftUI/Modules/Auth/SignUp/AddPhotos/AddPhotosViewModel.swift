//
//  AddPhotosViewModel.swift
//  Hush-SwiftUI
//
//  Created Dima Virych on 31.03.2020.
//  Copyright © 2020 AppServices. All rights reserved.
//

import Combine
import AVFoundation
import Photos
import UIKit

class AddPhotosViewModel: AddPhotosViewModeled {
    
    // MARK: - Properties

    @Published var messageLabel = "With Hush’s own Filters you can make \nyour photo as private as you like!"
    @Published var canGoNext = false
    @Published var isPickerSheetPresented = false
    @Published var isPickerPresented = false
    @Published var isPermissionDenied = false
    @Published var pickerSourceType: UIImagePickerController.SourceType = .photoLibrary
    @Published var selectedImage: UIImage?
    
    @Published private var cameraPickerSelected = false
    @Published private var libraryPickerSelected = false
    @Published private var deniedLibraryAccess = false
    @Published private var deniedCameraAccess = false
    @Published private var pickedSourceType: UIImagePickerController.SourceType?
    private var disposals = Set<AnyCancellable>()
    
    func appear() {
        disposals = []
        resetView()
        subscribe()
    }
    
    func disappear() {
        disposals = []
    }
    
    func takePhoto() {
        cameraPickerSelected = true
        isPickerSheetPresented = false
    }
    
    func cameraRoll() {
        libraryPickerSelected = true
        isPickerSheetPresented = false
    }
    
    func addPhoto() {
        isPickerSheetPresented = true
    }
}

extension AddPhotosViewModel {
    private func checkMediaAccess(type: UIImagePickerController.SourceType) {
        if type == .camera {
            guard AVCaptureDevice.authorizationStatus(for: .video) != .authorized else { return deniedCameraAccess = false }
            AVCaptureDevice.requestAccess(for: .video) { [weak self] allowed in
                DispatchQueue.main.async { [weak self] in
                    self?.deniedCameraAccess = !allowed
                }
            }
        } else {
            guard PHPhotoLibrary.authorizationStatus() != .authorized else { return deniedLibraryAccess = false }
            PHPhotoLibrary.requestAuthorization { [weak self] status in
                DispatchQueue.main.async {
                    self?.deniedLibraryAccess = status != .authorized
                }
            }
        }
    }
    
    private func resetView() {
        refreshPermissions()
        cameraPickerSelected = false
        libraryPickerSelected = false
        isPickerPresented = false
        pickedSourceType = nil
    }
    
    private func refreshPermissions() {
        deniedCameraAccess = AVCaptureDevice.authorizationStatus(for: .video) == .denied
        deniedLibraryAccess = PHPhotoLibrary.authorizationStatus() == .denied
    }
    
    private func subscribe() {
        $selectedImage
            .map { $0 != nil }
            .removeDuplicates()
            .assign(to: \.canGoNext, on: self)
            .store(in: &disposals)
        
        $cameraPickerSelected.combineLatest($libraryPickerSelected)
            .map { $0 || $1 }
            .assign(to: \.isPickerSheetPresented, on: self)
            .store(in: &disposals)
        
        let selectedCameraAndDeniedAccess = $cameraPickerSelected.combineLatest($deniedCameraAccess) { $0 && $1 }
        let selectedLibraryAndDeniedAccess = $libraryPickerSelected.combineLatest($deniedLibraryAccess) { $0 && $1 }
        
        selectedCameraAndDeniedAccess.combineLatest(selectedLibraryAndDeniedAccess) { $0 || $1 }
            .assign(to: \.isPermissionDenied, on: self)
            .store(in: &disposals)
        
        $cameraPickerSelected
            .map { _ in UIImagePickerController.SourceType.camera }
            .assign(to: \.pickedSourceType, on: self)
            .store(in: &disposals)
        
        $libraryPickerSelected
            .map { _ in UIImagePickerController.SourceType.photoLibrary }
            .assign(to: \.pickedSourceType, on: self)
            .store(in: &disposals)
        
        $pickedSourceType
            .compactMap { $0 }
            .assign(to: \.pickerSourceType, on: self)
            .store(in: &disposals)
        
        $cameraPickerSelected
            .combineLatest($deniedCameraAccess) { $0 && !$1 }
            .assign(to: \.isPickerPresented, on: self)
            .store(in: &disposals)
        
        $libraryPickerSelected
            .combineLatest($deniedLibraryAccess) { $0 && !$1 }
            .assign(to: \.isPickerPresented, on: self)
            .store(in: &disposals)
        
        
        $cameraPickerSelected
            .combineLatest($libraryPickerSelected) { $0 || $1 }
            .filter { $0 }
            .combineLatest($pickedSourceType.unwrap()) { $1 }
            .removeDuplicates()
            .sink { [unowned self] sourceType in
                self.checkMediaAccess(type: sourceType)
            }
        .store(in: &disposals)
    }
}
