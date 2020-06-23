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
    
    @Published var discoveries: [(name: String, age: Int, liked: Bool)] = []
    var settingsViewModel = DiscoveriesSettingsViewModel()
    
    init() {
        let user = Common.userInfo()
        AuthAPI.shared.discovery(uid: user.id!, location: user.address!, gender: "1", max_distance: "100", age_range: "18,30", check_online: "1") { (userList, error) in
            if let error = error {
                
            } else if let userList = userList {
                for value in userList {
                    let user: User = value!
                    let nAge: Int = Int(user.age!)!
                    let name: String = user.name!
                    self.discoveries.append((name: name, age: nAge, liked: false))
                }
            }
            
        }
//        for i in 18...99 {
//            discoveries.append((name: "Emily", age: i, liked: false))
//        }
    }
    
    func discovery(_ i: Int, _ j: Int) -> Discovery {
        discoveries[i * 2 + j]
    }
    
    func like(_ i: Int, _ j: Int) {
        discoveries[i * 2 + j].liked.toggle()
    }
}
