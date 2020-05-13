//
//  View+Ext.swift
//  Hush-SwiftUI
//
//  Created by Dima Virych on 02.04.2020.
//  Copyright © 2020 AppServices. All rights reserved.
//

import SwiftUI

extension View {
    func rotate(_ angle: CGFloat) -> some View {
        transformEffect(.init(rotationAngle: angle / 180.0 * CGFloat.pi))
    }
}

// MARK: - Frame
extension View {
    func frame(_ proxy: GeometryProxy, alignment: Alignment = .center) -> some View {
        frame(width: proxy.size.width, height: proxy.size.height, alignment: alignment)
    }
    
    func square(_ side: CGFloat) -> some View {
        frame(width: side, height: side)
    }
}

// MARK: - Gestures
extension View {
    func tapGesture(toggls toggle: Binding<Bool>) -> some View {
        onTapGesture {
            toggle.wrappedValue.toggle()
        }
    }
}
