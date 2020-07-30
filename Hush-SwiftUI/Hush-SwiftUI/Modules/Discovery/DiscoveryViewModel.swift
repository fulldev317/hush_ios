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
    @Published var discoveries: [Discover] = []
    @Published var isShowingIndicator: Bool = false
    var settingsViewModel = DiscoveriesSettingsViewModel()
    
    init() {
    
    }
    
    func discovery(_ i: Int, _ j: Int) -> Discover {
        discoveries[i * 2 + j]
    }
    
    func like(_ i: Int, _ j: Int) {
        var discover = discoveries[i * 2 + j];
        if let discover_liked = discover.liked {
            var strLiked = "0"
            if discover_liked == false {
                strLiked = "1"
                discover.fan = 1
                discover.liked = true
            } else {
                strLiked = "0"
                discover.fan = 0
                discover.liked = false
            }
            if let userID = discover.id {
                UserAPI.shared.game_like(toUserID: userID, like: strLiked) { (error) in
                    
                }
            }
            discoveries[i * 2 + j] = discover
        }

    }
        
    func loadDiscover(result: @escaping (Bool) -> Void) {
       
        self.isShowingIndicator = true
        AuthAPI.shared.meet(uid2: "0", uid3: "0") { (userList, error) in
            self.isShowingIndicator = false
            self.discoveries.removeAll()

            if error == nil {
                if let userList = userList {
                    for user in userList {
                        if let user = user {
                           self.discoveries.append(user)
                        }
                    }
                }
                result(true)
            } else {
                result(false)
            }

        }
    }
}
