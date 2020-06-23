//
//  MyProfileViewModel.swift
//  Hush-SwiftUI
//
//  Created Dima Virych on 07.04.2020.
//  Copyright © 2020 AppServices. All rights reserved.
//

import SwiftUI
import Combine
import AVFoundation
import Photos

class MyProfileViewModel: MyProfileViewModeled {
    
    // MARK: - Properties

    @Published var message = "Hellow World!"
    @Published var basicsViewModel: BioViewMode = BioViewMode()
    
    @Published var messageLabel = "With Hush’s own Filters you can make \nyour photo as private as you like!"
    @Published var canGoNext = false
    @Published var canGoToAR = false
    @Published var isPickerSheetPresented = false
    @Published var isPickerPresented = false
    @Published var isPermissionDenied = false
    @Published var pickerSourceType: UIImagePickerController.SourceType = .photoLibrary
    @Published var selectedIndex: Int = -1
    @Published var selectedImage: UIImage? = UIImage() {
        didSet {
            photoDatas[selectedIndex] = selectedImage!
        }
    }
    
    @Published var photoUrls: [String] = []
    @Published var photoDatas: [UIImage] = []
    @Published var locations: [String] = [
        "London, EN, UK",
        "Palo Alto, CA, US",
        "Los Angeles, CA, US",
    ]

    @Published private var cameraPickerSelected = false
    @Published private var libraryPickerSelected = false
    @Published private var libraryAuthorizationStatus = PHPhotoLibrary.authorizationStatus()
    @Published private var cameraAuthorizationStatus = AVCaptureDevice.authorizationStatus(for: .video)
    @Published private var pickedSourceType: UIImagePickerController.SourceType?
    private var disposals = Set<AnyCancellable>()

    init() {
        initPhotoData()

        let user = Common.userInfo()
        
        basicsViewModel.username = user.username ?? ""
        basicsViewModel.isPremium = user.premium ?? ""
        basicsViewModel.isVerified = user.verified ?? ""
        basicsViewModel.age = user.age ?? ""
        basicsViewModel.living = user.address ?? ""
        basicsViewModel.bio = user.bio ?? ""
        basicsViewModel.language = user.language ?? ""
        
        switch Int(user.gender ?? "0") {
        case 0:
            basicsViewModel.gender = Gender.male
            break
        case 1:
            basicsViewModel.gender = Gender.female
            break
        case 2:
            basicsViewModel.gender = Gender.lesbian
            break
        case 3:
            basicsViewModel.gender = Gender.gay
            break
        default:
            basicsViewModel.gender = Gender.male
        }
        
        let array = user.looking!.components(separatedBy: ",")
        if (array.count > 0) {
            let looking = array[0]
            
            switch Int(looking) {
            case 0:
                basicsViewModel.sexuality = Gender.male
                break
            case 1:
                basicsViewModel.sexuality = Gender.female
                break
            case 2:
                basicsViewModel.sexuality = Gender.lesbian
                break
            case 3:
                basicsViewModel.sexuality = Gender.gay
                break
            default:
                basicsViewModel.sexuality = Gender.male
            }
        }
        
   }

    func updateMessage() {

        message = "New Message"
    }
    
    func logout(result: @escaping (Bool, String) -> Void) {
        AuthAPI.shared.logout { (error) in
            if let error = error {
                result(false, error.message)
            } else {
                result(true, "")
            }
        }
    }
    
    func appear() {
        disposals = []
        resetView()
        subscribe()
    }

    func disappear() {
        disposals = []
    }
    
    func initPhotoData() {
        let user = Common.userInfo()
        let photos = user.photos
        for index in (0..<(photos?.count)!) {
            let photo:Photo = photos![index]
            photoUrls.append(photo.photo)
        }
        
        photoDatas.append(UIImage(named: "image2")!)
        photoDatas.append(UIImage(named: "image3")!)
        photoDatas.append(UIImage(named: "image4")!)
        photoDatas.append(UIImage(named: "plus")!)
        photoDatas.append(UIImage(named: "plus")!)
        photoDatas.append(UIImage(named: "plus")!)
        photoDatas.append(UIImage(named: "plus")!)
        photoDatas.append(UIImage(named: "plus")!)
    }

    func takePhoto() {
        cameraPickerSelected = true
        isPickerSheetPresented = false
        subscribe()
    }

    func cameraRoll() {
        libraryPickerSelected = true
        isPickerSheetPresented = false
        subscribe()
    }

    func addPhoto() {
        //appear()
        cameraPickerSelected = false
        libraryPickerSelected = false
        isPickerPresented = false
        pickedSourceType = nil
        isPickerSheetPresented = true
    }
}

extension MyProfileViewModel {
    
    private func checkMediaAccess(type: UIImagePickerController.SourceType) {
            if type == .camera {
                guard AVCaptureDevice.authorizationStatus(for: .video) != .authorized else {
                    return cameraAuthorizationStatus = .authorized
                }
                
                AVCaptureDevice.requestAccess(for: .video) { [weak self] allowed in
                    DispatchQueue.main.async { [weak self] in
                        self?.cameraAuthorizationStatus = allowed ? .authorized : .denied
                    }
                }
            } else {
                guard PHPhotoLibrary.authorizationStatus() != .authorized else {
                    return libraryAuthorizationStatus = .authorized
                }
                
                PHPhotoLibrary.requestAuthorization { [weak self] status in
                    DispatchQueue.main.async {
                        self?.libraryAuthorizationStatus = status
                    }
                }
            }
        }
        
        private func resetView() {
            refreshPermissions()
            cameraPickerSelected = false
            //libraryPickerSelected = false
            isPickerPresented = false
            pickedSourceType = nil
        }
        
        private func refreshPermissions() {
            cameraAuthorizationStatus = AVCaptureDevice.authorizationStatus(for: .video)
            libraryAuthorizationStatus = PHPhotoLibrary.authorizationStatus()
        }
        
        private func subscribe() {
            $selectedImage
                .map { $0 != nil }
                .removeDuplicates()
                .assign(to: \.canGoNext, on: self)
                .store(in: &disposals)

    //        $cameraPickerSelected.combineLatest($libraryPickerSelected)
    //            .map { $0 || $1 }
    //            .assign(to: \.isPickerSheetPresented, on: self)
    //            .store(in: &disposals)

            let allowedCameraAccess = $cameraAuthorizationStatus.map { $0 == .authorized }
            let deniedCameraAccess = $cameraAuthorizationStatus.map { $0 == .denied }
            let deniedLibraryAccess = $libraryAuthorizationStatus.map { $0 == .denied }
            let selectedCameraAndDeniedAccess = $cameraPickerSelected.combineLatest(deniedCameraAccess) { $0 && $1 }
            let selectedLibraryAndDeniedAccess = $libraryPickerSelected.combineLatest(deniedLibraryAccess) { $0 && $1 }
            
            selectedCameraAndDeniedAccess.combineLatest(selectedLibraryAndDeniedAccess) { $0 || $1 }
                .assign(to: \.isPermissionDenied, on: self)
                .store(in: &disposals)
            
            if (cameraPickerSelected) {
                $cameraPickerSelected
                    .map { _ in UIImagePickerController.SourceType.camera }
                    .assign(to: \.pickedSourceType, on: self)
                    .store(in: &disposals)
            } else if (libraryPickerSelected){
                $libraryPickerSelected
                    .map { _ in UIImagePickerController.SourceType.photoLibrary }
                    .assign(to: \.pickedSourceType, on: self)
                    .store(in: &disposals)
            }
            
            $pickedSourceType
                .compactMap { $0 }
                .assign(to: \.pickerSourceType, on: self)
                .store(in: &disposals)
            
            $cameraPickerSelected
                .combineLatest(allowedCameraAccess) { $0 && $1 }
                .assign(to: \.canGoToAR, on: self)
                .store(in: &disposals)
            
            $libraryPickerSelected
                .combineLatest(deniedLibraryAccess) {
                    $0 && !$1
                }
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

class BioViewMode: ObservableObject {
    
    @Published var username: String = "username"
    @Published var isPremium = "Yes"
    @Published var isVerified = "No"
    @Published var age = "21"
    @Published var gender = Gender.male
    @Published var sexuality = Gender.female
    @Published var living = "London, EN, UK"
    @Published var bio = "Hi, I'm Jack, 18 years old and I'm from London, Unite Kindom"
    @Published var language = "English"
    
    init() {
        
    }
}
