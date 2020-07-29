//
//  CardCuraselViewModel.swift
//  Hush-SwiftUI
//
//  Created Dima Virych on 03.04.2020.
//  Copyright © 2020 AppServices. All rights reserved.
//

import SwiftUI
import Combine
import Foundation

class CardCuraselViewModel: CardCuraselViewModeled {
        
    // MARK: - Properties
    
    @Published var message = "Hellow World!"
    @Published var isShowingIndicator: Bool = false
    //@Published var photos: [String] = []
    @Published var name: String = "Alex"
    @Published var age: String = "32"
    @Published var address: String = "London, UK"
    @Published var discoveries: [Discover] = []

    init() {

    }
    
    func loadDiscover(result: @escaping (Bool) -> Void) {
       
        self.isShowingIndicator = true
        AuthAPI.shared.meet(uid2: "0", uid3: "0") { (userList, error) in
            self.isShowingIndicator = false
            self.discoveries.removeAll()
            //self.photos.removeAll()
            
            if error == nil {
               if let userList = userList {
                    for user in userList {
                        if self.discoveries.count == 8 {
                            break;
                        }
                        self.discoveries.append(user!)
//                        if let url = user?.photo {
//                            self.photos.append(url)
//                        }
                    }
               }
                result(true)
            } else {
                result(false)
            }

        }
    }
    
    
    func updateMessage() {
        
        message = "New Message"
    }
    
    func viewModel(for index: Int) -> CardCuraselElementViewModel {
       
        return CardCuraselElementViewModel()
    }
}

struct CardCuraselViewModel_Previews: PreviewProvider {
    static var previews: some View {
        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
    }
}
