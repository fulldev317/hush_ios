//
//  DiscoveryViewModel.swift
//  Hush-SwiftUI
//
//  Created Dima Virych on 02.04.2020.
//  Copyright © 2020 AppServices. All rights reserved.
//

import SwiftUI
import Combine

class DiscoveryViewModel: DiscoveryViewModeled {

    // MARK: - Properties
    
    //@Published var discoveries: [(name: String, age: Int, image: String, liked: Bool)] = []
    @Published var discoveries: [User] = []
    @Published var isShowingIndicator: Bool = false
    var settingsViewModel = DiscoveriesSettingsViewModel()
    
    init() {
    
    }
    
    func discovery(_ i: Int, _ j: Int) -> User {
        discoveries[i * 2 + j]
    }
    
    func like(_ i: Int, _ j: Int) {
        var discover = discoveries[i * 2 + j];
        discover.liked!.toggle()
        //discoveries[i * 2 + j].liked.toggle()
    }
        
    func loadDiscover(result: @escaping (Bool) -> Void) {

        let user = Common.userInfo()
        
        AuthAPI.shared.discovery(uid: user.id!, location: user.address!, gender: "1", max_distance: "100", age_range: "18,30", check_online: "1") { (userList, error) in
            
            if let error = error {
                result(false)
            } else if let userList = userList {
                for value in userList {
                    var user: User = value!
                    let nAge: Int = Int(user.age!)!
                    let name: String = user.name!
                    let photo: String = user.profilePhotoBig!
                    user.liked = false
                    self.discoveries.append(user)
                }
                result(true)
                
            }
        }
    }
}
