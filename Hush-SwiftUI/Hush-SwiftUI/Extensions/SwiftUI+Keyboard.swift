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
        let willShow = NotificationCenter.default.publisher(for: UIResponder.keyboardWillShowNotification).map {
            $0.keyboardHeight
        }
        let willHide = NotificationCenter.default.publisher(for: UIResponder.keyboardWillHideNotification).map { _ in
            CGFloat()
        }
        return Merge(willShow, willHide).eraseToAnyPublisher()
    }
}

struct KeyboardAdaptive: ViewModifier {
    
    let keyboardPresented: Binding<Bool>?
    @State private var bottomPadding: CGFloat = 0
    
    func body(content: Content) -> some View {
        GeometryReader { geometry in
            content
                .padding(.bottom, self.bottomPadding)
                .onReceive(Publishers.keyboardHeight) { keyboardHeight in
                    self.bottomPadding = keyboardHeight
                    self.keyboardPresented?.wrappedValue = !keyboardHeight.isZero
            }
            .animation(.easeOut(duration: 0.16))
        }
    }
}

struct KeyboardObserving: ViewModifier {
    let keyboardHeight: Binding<CGFloat>
    let animation: Animation?
    
    func body(content: Content) -> some View {
        content
            .background(Color.clear)
            .onReceive(Publishers.keyboardHeight) { keyboardHeight in
                if let animation = self.animation {
                    withAnimation(animation) {
                        self.keyboardHeight.wrappedValue = keyboardHeight
                    }
                } else {
                    self.keyboardHeight.wrappedValue = keyboardHeight
                }
            }   
    }
}

extension View {
    func keyboardAdaptive(_ keyboardPresented: Binding<Bool>? = nil) -> some View {
        ModifiedContent(content: self, modifier: KeyboardAdaptive(keyboardPresented: keyboardPresented))
    }
    
    func observeKeyboardHeight(_ observer: Binding<CGFloat>, withAnimation animation: Animation? = nil) -> some View {
        ModifiedContent(content: self, modifier: KeyboardObserving(keyboardHeight: observer, animation: animation))
    }
}
