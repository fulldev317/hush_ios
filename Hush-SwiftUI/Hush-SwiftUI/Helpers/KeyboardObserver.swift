//
//  KeyboardObserver.swift
//  Hush-SwiftUI
//
//  Created by Dima Virych on 30.03.2020.
//  Copyright © 2020 AppServices. All rights reserved.
//

import UIKit

class KeyboardObserver: ObservableObject {
    
    @Published var height: CGFloat = 0
    @Published var keyboardShowed = false
    
    init() {
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: .main) { [weak self] notif in
            let frame = notif.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! CGRect
            self?.height = frame.height
            self?.keyboardShowed = true
        }
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: .main) { [weak self] notif in
            
            self?.height = 0
            self?.keyboardShowed = false
        }
    }
    
    deinit {
        
        NotificationCenter.default.removeObserver(self)
    }
}
