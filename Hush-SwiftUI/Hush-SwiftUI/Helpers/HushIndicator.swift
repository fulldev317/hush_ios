//
//  HapticButton.swift
//  Hush-SwiftUI
//
//  Created by Dima Virych on 30.03.2020.
//  Copyright © 2020 AppServices. All rights reserved.
//

import SwiftUI

public struct HushIndicator: View {
    
    private let isShowing: Bool
    
    public init(showing: Bool) {
        self.isShowing = showing
    }
    
    public var body: some View {
        
        VStack {
            ActivityIndicator(isAnimating: .constant(true), style: .large)
        }
        .frame(width: 80,
               height: 80)
        .background(Color.secondary.colorInvert())
        //.background(Color.gray)
        .foregroundColor(Color.primary)
        .cornerRadius(15)
        .opacity(self.isShowing ? 1 : 0)
    }
}
