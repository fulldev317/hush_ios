//
//  UserProfileViewModel.swift
//  Hush-SwiftUI
//
//  Created Dima Virych on 09.04.2020.
//  Copyright © 2020 AppServices. All rights reserved.
//

import SwiftUI
import Combine

class UserProfileViewModel: UserProfileViewModeled {

    // MARK: - Properties
    
    @Published var isShowingIndicator: Bool = false
    @Published var photoUrls: [String] = []
    @Published var unlockedPhotos: Set<Int> = []
    @Published var galleriaUrls: [String] = []
    @Published var mode: UserProfileMode = .photo
    @Published var userId: String = ""
    @Published var name: String = ""
    @Published var profilePhoto: String = ""
    @Published var address: String = ""
    @Published var bio: String = ""
    @Published var lookfor: String = "Female"
    @Published var herefor: String = "Fun"
    @Published var gender: String = "Male"
    @Published var relationship: String = "Single"
    @Published var sex: String = "Gay"
    @Published var smoke: String = "Yes"
    @Published var ethnicity: String = "White"
    @Published var body_type: String = "Thin"
    @Published var living: String = "Alone"
    @Published var isFan: Bool = false

    var aboutMe = "Hello World!"
    var location = "Hello World!"
    //let photos: [UIImage] = Array(0..<3).compactMap { UIImage(named: "image\($0.isMultiple(of: 2) ? 2 : 3)") }
    
    let stories: [UIImage] = Array(0..<20).compactMap { UIImage(named: "image\($0.isMultiple(of: 2) ? 2 : 3)") }
    
    init(user: User?) {
        var userInfo: User
        if user == nil {
            userInfo = Common.userInfo()
        } else {
            userInfo = user!
        }
        userId = userInfo.id ?? "1"
        name = userInfo.name ?? "Jane"
        address = userInfo.address ?? "London, UK"
        bio = userInfo.bio ?? "I'm Jain, is 20 years old."
        profilePhoto = userInfo.profilePhoto ?? ""
        
        relationship = "Single"

        if user?.questions != nil {
            for question in user!.questions! {
                if question.id == "1" {
                    for answer in question.answers! {
                        if answer.id == question.userAnswer {
                            relationship = answer.answer!
                        }
                    }
                }
                else if question.id == "2" {
                    for answer in question.answers! {
                        if answer.id == question.userAnswer {
                            sex = answer.answer!
                        }
                    }
                }
                else if question.id == "5" {
                    for answer in question.answers! {
                        if answer.id == question.userAnswer {
                            ethnicity = answer.answer!
                        }
                    }
                }
                else if question.id == "6" {
                    for answer in question.answers! {
                        if answer.id == question.userAnswer {
                            body_type = answer.answer!
                        }
                    }
                }
                else if question.id == "7" {
                    for answer in question.answers! {
                        if answer.id == question.userAnswer {
                            living = answer.answer!
                        }
                    }
                }
                else if question.id == "8" {
                    for answer in question.answers! {
                        if answer.id == question.userAnswer {
                            smoke = answer.answer!
                        }
                    }
                }
            }
        }
        let nLookFor = Int(userInfo.looking ?? "1")
        switch nLookFor {
        case 1:
            lookfor = "Male"
            break;
        case 2:
            lookfor = "Female"
            break;
        case 3:
            lookfor = "Guy"
            break;
        default:
            lookfor = "Male"

        }
        herefor = userInfo.hereFor ?? "1"
        gender = userInfo.gender ?? "0"
        
        isFan = userInfo.isFan == 1
        
        let photos = userInfo.photos ?? []
        let photo_count = photos.count
       
        for index in (0 ..< photo_count) {
            let photo:Photo = photos[index]
            photoUrls.append(photo.photo)
            unlockedPhotos.insert(index)
        }
        
        let gallerias = userInfo.galleria ?? []
        let galleria_count = gallerias.count
        
        for index in (0 ..< galleria_count) {
            let gallery:Gallery = gallerias[index]
            galleriaUrls.append(gallery.image ?? "")
        }
    }
    
    func updateMessage() {
        
    }
    
    func switchMode() {
        
        mode.toggle()
    }
    
    func userLike(like: String) {
        UserAPI.shared.game_like(toUserID: self.userId, like: like) { (error) in
            if (error == nil) {
                
            }
        }
    }
    
    func getReportList(result: @escaping ([String]) -> Void) {
        UserAPI.shared.report_reason_list { (list, error) in
            if (error == nil) {
                if let reason_list = list {
                    result(reason_list)
                }
            } else {
                result(["1","2","3"])
            }
        }
    }

    func reportUser(reason: String, result: @escaping (Bool) -> Void) {
        self.isShowingIndicator = true
        UserAPI.shared.report_user(report_id: userId, report_reason: reason) { (error) in
            self.isShowingIndicator = false
            if error == nil {
                result(true)
            }
            result(false)
        }
    }
    
    func blockUser(result: @escaping (Bool) -> Void) {
        self.isShowingIndicator = true
        UserAPI.shared.block_user(report_id: userId) { (error) in
            self.isShowingIndicator = false
            if error == nil {
                result(true)
            }
            result(false)
        }
    }
    
}
