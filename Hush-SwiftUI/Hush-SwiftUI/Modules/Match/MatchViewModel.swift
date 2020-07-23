//
//  MatchViewModel.swift
//  Hush-SwiftUI
//
//  Created Maksym on 06.08.2020.
//  Copyright © 2020 AppServices. All rights reserved.
//

import SwiftUI
import Combine

class MatchViewModel: MatchViewModeled {

    // MARK: - Properties
    
    @Published var matches: [Match] = []
    @Published var matches1: [Discover] = []
    @Published var isShowingIndicator: Bool = false

    init() {
       
    }
    
    func match(_ i: Int, _ j: Int) -> Match {
        matches[i * 2 + j]
    }
    
    func like(_ i: Int, _ j: Int) {
        var match = matches[i * 2 + j];
        match.liked!.toggle()
    }
    
    func loadMatches(result: @escaping (Bool) -> Void) {

       self.isShowingIndicator = true
       AuthAPI.shared.meet(uid2: "0", uid3: "0") { (userList, error) in
           self.isShowingIndicator = false
           self.matches.removeAll()

           if error == nil {
              if let userList = userList {
                  for user in userList {
                      self.matches1.append(user!)
                  }
              }
               result(true)
           } else {
               result(false)
           }
        }
    }
    
    func loadMyLikes(result: @escaping (Bool) -> Void) {
        
        self.isShowingIndicator = true
        
        MatchesAPI.shared.my_likes(completion: { (matchList, error) in
            self.isShowingIndicator = false
            self.matches.removeAll()
            
            if error == nil {
                if let matchList = matchList {
                    for match in matchList {
                        self.matches.append(match!)
                    }
                }
                result(true)
            } else {
                result(false)
            }
        })
    }
}
