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
        discover.liked!.toggle()
        //discoveries[i * 2 + j].liked.toggle()
    }
        
    func loadDiscover(result: @escaping (Bool) -> Void) {

        self.isShowingIndicator = true
        self.discoveries.removeAll()
        AuthAPI.shared.meet(uid2: "0", uid3: "0") { (userList, error) in
            self.isShowingIndicator = false

            if error == nil {
               if let userList = userList {
                   for user in userList {
                       self.discoveries.append(user!)
                   }
               }
                result(true)
            } else {
                result(false)
            }

        }
    }
}
