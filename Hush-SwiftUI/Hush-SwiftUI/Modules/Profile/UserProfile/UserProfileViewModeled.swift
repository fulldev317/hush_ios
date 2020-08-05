//
//  UserProfileViewModeled.swift
//  Hush-SwiftUI
//
//  Created Dima Virych on 09.04.2020.
//  Copyright © 2020 AppServices. All rights reserved.
//

import Combine
import UIKit

enum UserProfileMode {
    case photo
    case info
    
    mutating func toggle() {
        
        self = self == .photo ? .info : .photo
    }
}

protocol UserProfileViewModeled: ObservableObject {
    
    var mode: UserProfileMode { get }
    var isShowingIndicator: Bool { get set }
    var aboutMe: String { get set }
    var location: String { get set }
    var profilePhoto: String { get set }
    var photoUrls: [String] { get set }
    var galleriaUrls: [String] { get set }
    var unlockedPhotos: Set<Int> { get set }
    var stories: [UIImage] { get }
    var userId: String { get set }
    var name: String { get set }
    var address: String { get set }
    var bio: String { get set }
    var lookfor: String { get set }
    var gender: String { get set }
    var herefor: String { get set }
    var relationship: String { get set }
    var sex: String { get set }
    var smoke: String { get set }
    var ethnicity: String { get set }
    var body_type: String { get set }
    var living: String { get set }
    var isFan: Bool { get set }
    func switchMode()
    func userLike(like: String)
    func getReportList(result: @escaping ([String]) -> Void)
    func reportUser(reason: String, result: @escaping (Bool) -> Void)
    func blockUser(result: @escaping (Bool) -> Void) 
}
