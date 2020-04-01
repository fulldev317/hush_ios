//
//  SwiftUI+Keyboard.swift
//  Hush-SwiftUI
//
//  Created by Dima Virych on 01.04.2020.
//  Copyright © 2020 AppServices. All rights reserved.
//

import Foundation
import Combine
import UIKit
import SwiftUI

extension Notification {
    
    var keyboardHeight: CGFloat {
        
        (userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect)?.height ?? 0
    }
}

extension Publishers {

    static var keyboardHeight: AnyPublisher<CGFloat, Never> {
        
        let willShow = NotificationCenter.default.publisher(for: UIApplication.keyboardWillShowNotification)
            .map { $0.keyboardHeight }
        
        let willHide = NotificationCenter.default.publisher(for: UIApplication.keyboardWillHideNotification)
            .map { _ in CGFloat(0) }
    
        return MergeMany(willShow, willHide)
            .eraseToAnyPublisher()
    }
}

struct KeyboardAdaptive: ViewModifier {
    
    @State private var bottomPadding: CGFloat = 0
    
    func body(content: Content) -> some View {
        
        GeometryReader { geometry in
            content
                .padding(.bottom, self.bottomPadding)
                .onReceive(Publishers.keyboardHeight) { keyboardHeight in
                    self.bottomPadding = keyboardHeight
            }
            .animation(.easeOut(duration: 0.16))
        }
    }
}

extension View {
   
    func keyboardAdaptive() -> some View {
    
        ModifiedContent(content: self, modifier: KeyboardAdaptive())
    }
}
