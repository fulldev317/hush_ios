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
import PushNotifications

class MyProfileViewModel: MyProfileViewModeled {
    
    // MARK: - Properties
    let pushNotifications = PushNotifications.shared

    @Published var message = "Hellow World!"
    @Published var basicsViewModel: BioViewMode = BioViewMode()
    @Published var unlockedPhotos: Set<Int> = []
    @Published var isShowingIndicator: Bool = false
    @Published var languageNames: [String] = []
    @Published var messageLabel = "With Hush’s own Filters you can make \nyour photo as private as you like!"
    @Published var canGoNext = false
    @Published var canGoToAR = false
    @Published var isPickerSheetPresented = false
    @Published var isPickerPresented = false
    @Published var isPermissionDenied = false
    @Published var pickerSourceType: UIImagePickerController.SourceType = .photoLibrary
    @Published var selectedIndex: Int = -1
    @Published var premium: String = "Activate"
    
    @Published var selectedImage: UIImage? = UIImage() {
        didSet {
            if (selectedImage != nil) {
                uploadImage(userImage: selectedImage!)
            }
        }
    }
    
    @Published var photoUrls: [String] = []
    @Published var photoIDs: [String] = []
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
    private var cancellable0: AnyCancellable?
    private var cancellable1: AnyCancellable?
    private var cancellable2: AnyCancellable?
    private var cancellable3: AnyCancellable?
    
    init() {
        let user = Common.userInfo()
        if let userId = user.id {
            self.isShowingIndicator = true
            AuthAPI.shared.get_user_data(userId: userId) { (user, error) in
                self.isShowingIndicator = false
                if error == nil {
                     if let user = user {
                        Common.setUserInfo(user)
                        self.setPageData(user: user)
                     }
                 }
            }
        }
//
//        if let looking = user.looking {
//            let array = looking.components(separatedBy: ",")
//            if (array.count > 0) {
//                let looking = array[0]
//
//                switch Int(looking) {
//                case 0:
//                    basicsViewModel.sexuality = Gender.male
//                    break
//                case 1:
//                    basicsViewModel.sexuality = Gender.female
//                    break
//                case 2:
//                    basicsViewModel.sexuality = Gender.lesbian
//                    break
//                case 3:
//                    basicsViewModel.sexuality = Gender.gay
//                    break
//                default:
//                    basicsViewModel.sexuality = Gender.male
//                }
//            }
//        }
    }
    
    func setPageData(user: User) {

         initPhotoData(user: user)

         basicsViewModel.username = user.name ?? ""
         
        
         if let verified = user.verified {
             if verified == "1" {
                 basicsViewModel.isVerified = "Yes"
             } else {
                 basicsViewModel.isVerified = "No"
             }
         } else {
             basicsViewModel.isVerified = "No"
         }

         basicsViewModel.age = user.age ?? ""
         basicsViewModel.bio = user.bio ?? ""
         basicsViewModel.language = user.language ?? ""
         basicsViewModel.matches = String(user.totalMatches ?? 0)
         basicsViewModel.visitedMe = user.totalVisits ?? "0"
         basicsViewModel.likesMe = user.totalFans ?? "0"
         basicsViewModel.myLikes = user.totalMyLikes ?? "0"
         basicsViewModel.noti_matches = user.notifications?.matchMe.inapp == "1"
         basicsViewModel.noti_likeMe = user.notifications?.fan.inapp == "1"
         basicsViewModel.noti_messages = user.notifications?.message.inapp == "1"
         basicsViewModel.noti_nearby = user.notifications?.nearMe.inapp == "1"
         
         cancellable0 = basicsViewModel.$noti_matches.sink(receiveCompletion: { (completion) in
         }) { (value) in
             if (value != self.basicsViewModel.noti_matches) {
                 var user = Common.userInfo()
                 user.notifications?.matchMe.inapp = value ? "1" : "0"
                 Common.setUserInfo(user)
                 self.updateNotification(notification_type: "match_me", toogled: value)
             }
         }
         
         cancellable1 = basicsViewModel.$noti_likeMe.sink(receiveCompletion: { (completion) in
         }) { (value) in
             if (value != self.basicsViewModel.noti_likeMe) {
                 var user = Common.userInfo()
                 user.notifications?.fan.inapp = value ? "1" : "0"
                 Common.setUserInfo(user)
                 self.updateNotification(notification_type: "fan", toogled: value)
             }
         }
         
         cancellable2 = basicsViewModel.$noti_messages.sink(receiveCompletion: { (completion) in
         }) { (value) in
             if (value != self.basicsViewModel.noti_messages) {
                 var user = Common.userInfo()
                 user.notifications?.message.inapp = value ? "1" : "0"
                 Common.setUserInfo(user)
                 self.updateNotification(notification_type: "message", toogled: value)
             }
         }
         
         cancellable3 = basicsViewModel.$noti_nearby.sink(receiveCompletion: { (completion) in
         }) { (value) in
             if (value != self.basicsViewModel.noti_nearby) {
                 var user = Common.userInfo()
                 user.notifications?.message.inapp = value ? "1" : "0"
                 Common.setUserInfo(user)
                 self.updateNotification(notification_type: "near_me", toogled: value)
             }
         }
         
         switch Int(user.gender ?? "1") {
         case 1:
             basicsViewModel.gender = Gender.male
             break
         case 2:
             basicsViewModel.gender = Gender.female
             break
         case 3:
             basicsViewModel.gender = Gender.lesbian
             break
         case 4:
             basicsViewModel.gender = Gender.gay
             break
         default:
             basicsViewModel.gender = Gender.male
         }
         
         switch Int(user.looking ?? "1") {
         case 1:
             basicsViewModel.looking = Gender.male
             break
         case 2:
             basicsViewModel.looking = Gender.female
             break
         case 3:
             basicsViewModel.looking = Gender.lesbian
             break
         case 4:
             basicsViewModel.looking = Gender.gay
             break
         default:
             basicsViewModel.looking = Gender.male
         }
         
         var s_question: Question?
         var live_question: Question?
         if let questions = user.questions {
             for question in questions {
                 if question.id == "2" {
                     s_question = question
                 }
                 if question.id == "7" {
                     live_question = question
                 }
             }
         }
         
         if (s_question != nil) {
             if s_question?.userAnswer == "" {
                 basicsViewModel.sexuality = Sex.gay
             } else {
                 switch Int(s_question?.userAnswer ?? "1") {
                 case 1:
                     basicsViewModel.sexuality = Sex.gay
                     break
                 case 2:
                     basicsViewModel.sexuality = Sex.open
                     break
                 case 3:
                     basicsViewModel.sexuality = Sex.straight
                     break
                 case 4:
                     basicsViewModel.sexuality = Sex.bisexual
                     break
                 default:
                     basicsViewModel.sexuality = Sex.gay
                 }
                 
             }
         } else {
             basicsViewModel.sexuality = Sex.gay
         }
         
         if (live_question != nil) {
             if live_question?.userAnswer == "" {
                 basicsViewModel.living = Living.alone
             } else {
                 switch Int(live_question?.userAnswer ?? "1") {
                 case 1:
                     basicsViewModel.living = Living.alone
                     break
                 case 2:
                     basicsViewModel.living = Living.parent
                     break
                 case 3:
                     basicsViewModel.living = Living.partner
                     break
                 case 4:
                     basicsViewModel.living = Living.student
                     break
                 default:
                     basicsViewModel.living = Living.alone
                 }
             }
         } else {
             basicsViewModel.living = Living.alone
         }
         
         if let premium = user.premium {
             if premium == "1" {
                 Common.setPremium(true)
                 self.premium = "Yes"
             } else {
                 Common.setPremium(false)
                 self.premium = "Activate"
             }
         }
    }
    func updateName(name: String) {
        UserAPI.shared.update_name(name: name) { (error) in
            if error == nil {
                var user = Common.userInfo()
                user.name = name
                Common.setUserInfo(user)
            }
        }
    }
    
    func updateAge(age: String) {
        UserAPI.shared.update_age(age: age) { (error) in
            if error == nil {
                var user = Common.userInfo()
                user.age = age
                Common.setUserInfo(user)
            }
        }
    }
    
    func updateBio(bio: String) {
        UserAPI.shared.update_bio(bio: bio) { (error) in
            if error == nil {
                var user = Common.userInfo()
                user.bio = bio
                Common.setUserInfo(user)
            }
        }
    }
    
    func uploadImage(userImage: UIImage) {
        self.isShowingIndicator = true

        UserAPI.shared.upload_image(image: userImage) { (dic, error) in

            if error == nil {
                let imagePath = dic!["path"] as! String
                let imageThumb = dic!["thumb"] as! String

                if (self.selectedIndex < self.photoIDs.count) {
                    let imageID = self.photoIDs[self.selectedIndex]
                    UserAPI.shared.update_image(imageID: imageID, path: imagePath, thumb: imageThumb) { (error) in
                        self.isShowingIndicator = false

                        if error == nil {
                            self.photoUrls[self.selectedIndex] = imageThumb
                            var user = Common.userInfo()
                                if let photos = user.photos {
                                    var photoList: [Photo] = photos
                                    var photo = photos[self.selectedIndex]
                                    photo.thumb = imageThumb
                                    photo.photo = imagePath
                                    photoList[self.selectedIndex] = photo
                                    user.photos = photoList
                                    Common.setUserInfo(user)
                            }
                        }
                    }
                } else {
                    UserAPI.shared.add_image(path: imagePath, thumb: imageThumb) { (imageID, error) in
                        self.isShowingIndicator = false

                        if error == nil {
                            if let imageID = imageID {
                                self.photoUrls.append(imageThumb)
                                self.photoIDs.append(imageID)
                                self.unlockedPhotos.insert(self.photoUrls.count - 1)

                                var user = Common.userInfo()
                                let newPhoto = Photo(id: "123", thumb: imageThumb, photo: imagePath, approved: "1", profile: "1", blocked: "0")
                                if let photos = user.photos {
                                    var photoList: [Photo] = photos
                                    photoList.append(newPhoto)
                                    user.photos = photoList
                                    Common.setUserInfo(user)
                                }
                            }
                        }
                    }
                }
            } else {
                self.isShowingIndicator = false
            }
        }
    }
    
    func updateNotification(notification_type: String, toogled: Bool) {
       
        UserAPI.shared.update_notification(notification_type: notification_type, enable: toogled) { (enabled, error) in
            if error == nil {
                if (enabled) {
                }
            } else {
            }
        }
    }
    
    func updateGender(gender: String) {
       
        let gender_index = Common.getGenderIndexValue(gender)

        UserAPI.shared.update_gender(gender: gender_index) { ( error) in
            if (error == nil) {
                var user = Common.userInfo()
                user.gender = gender_index
                Common.setUserInfo(user)
            }
        }
    }
    
    func updateSex(sex: String) {
        let s_index = Common.getSexIndexValue(sex)

        UserAPI.shared.update_sexuality(s: s_index) { (user, error) in
            if (error == nil) {
                if (user != nil) {
                   Common.setUserInfo(user!)
                }
            }
        }
    }
    
    func updateLiving(living: String) {
       let living_index = Common.getLivingIndexValue(living)

        UserAPI.shared.update_living(living: living_index) { (user, error) in
            if (error == nil) {
                if (user != nil) {
                    Common.setUserInfo(user!)
                }
            }
        }
    }
    
    func updateMessage() {
        message = "New Message"
    }
    
    func logout(result: @escaping (Bool, String) -> Void) {
        
        pushNotifications.clearAllState {
        }
        
        Common.setPremium(false)
        
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
    
    func initPhotoData(user: User) {
        
        let photos = user.photos
        if let count = photos?.count {
            for index in (0 ..< count) {
                let photo:Photo = photos![index]
                photoUrls.append(photo.photo)
                photoIDs.append(photo.id)
                unlockedPhotos.insert(index)
            }
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
    
    @Published var username: String = ""
    @Published var isPremium = "Yes"
    @Published var isVerified = "No"
    @Published var age = ""
    @Published var gender = Gender.male
    @Published var looking = Gender.female
    @Published var sexuality = Sex.gay
    @Published var living = Living.alone
    @Published var bio = "Hi, I'm Jack, 18 years old and I'm from London, Unite Kindom"
    @Published var language = "English"
    @Published var matches = "0"
    @Published var visitedMe = "0"
    @Published var likesMe = "0"
    @Published var myLikes = "0"
    @Published var noti_matches = false
    @Published var noti_likeMe = false
    @Published var noti_messages = false
    @Published var noti_nearby = false
    init() {
    }
    
    
}
