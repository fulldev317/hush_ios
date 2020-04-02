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
