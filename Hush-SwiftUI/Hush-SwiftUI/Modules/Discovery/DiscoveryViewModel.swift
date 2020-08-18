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
    @Published var matches: [Discover] = []
    @Published var visitedmes: [Discover] = []
    @Published var mylikes: [Discover] = []
    @Published var likemes: [Discover] = []

    @Published var isShowingIndicator: Bool = false
    var page_num = 0
    
    var settingsViewModel = DiscoveriesSettingsViewModel()
    
    init() {
       
    }
    
    func setSettingsModel() {
        let user: User = Common.userInfo()
               
        switch Int(user.gender ?? "1") {
        case 1:
           settingsViewModel.gender = Gender.male
           break
        case 2:
           settingsViewModel.gender = Gender.female
           break
        case 3:
           settingsViewModel.gender = Gender.lesbian
           break
        case 4:
           settingsViewModel.gender = Gender.gay
           break
        default:
           settingsViewModel.gender = Gender.male
        }
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
        
    func loadDiscover(page: Int, result: @escaping (Bool) -> Void) {
       
        self.isShowingIndicator = true
        AuthAPI.shared.meet(uid2: String(page), uid3: "0") { (userList, error) in
            self.isShowingIndicator = false
            if page == 0 {
                self.discoveries.removeAll()
            }
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
    
    func loadMatches(result: @escaping (Bool) -> Void) {

        self.isShowingIndicator = true
       
        MatchesAPI.shared.matches( completion: { (matchList, error) in
            self.isShowingIndicator = false
            self.matches.removeAll()
           
            if error == nil {
                if let matchList = matchList {
                    for match in matchList {
                        if let match = match {
                            let discover: Discover = Discover(match: match)
                            self.matches.append(discover)
                        }
                   }
               }
               result(true)
           } else {
               result(false)
           }
       })
    }
    
    func loadMyLikes(result: @escaping (Bool) -> Void) {
        self.isShowingIndicator = true
        MatchesAPI.shared.my_likes(completion: { (matchList, error) in
            self.isShowingIndicator = false
            self.mylikes.removeAll()
           
            if error == nil {
                if let matchList = matchList {
                    for match in matchList {
                        if let match = match {
                        let discover: Discover = Discover(match: match)
                            self.mylikes.append(discover)
                        }
                   }
               }
               result(true)
           } else {
               result(false)
           }
       })
    }
    
    func loadVisitedMe(result: @escaping (Bool) -> Void) {
        self.isShowingIndicator = true
        MatchesAPI.shared.visited_me(completion: { (matchList, error) in
            self.isShowingIndicator = false
            self.visitedmes.removeAll()
           
            if error == nil {
                if let matchList = matchList {
                    for match in matchList {
                        if let match = match {
                        let discover: Discover = Discover(match: match)
                            self.visitedmes.append(discover)
                        }
                   }
               }
               result(true)
           } else {
               result(false)
           }
       })
    }
    
    func loadLikesMe(result: @escaping (Bool) -> Void) {
        self.isShowingIndicator = true
        MatchesAPI.shared.likes_me(completion: { (matchList, error) in
            self.isShowingIndicator = false
            self.likemes.removeAll()
           
            if error == nil {
                if let matchList = matchList {
                    for match in matchList {
                        if let match = match {
                        let discover: Discover = Discover(match: match)
                            self.likemes.append(discover)
                        }
                   }
               }
               result(true)
           } else {
               result(false)
           }
       })
    }
}
