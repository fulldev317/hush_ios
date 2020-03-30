//
//  Font+Ext.swift
//  Hush-SwiftUI
//
//  Created by Dima Virych on 30.03.2020.
//  Copyright © 2020 AppServices. All rights reserved.
//

import SwiftUI

extension Font {
    
    static func medium(_ size: CGFloat = 18) -> Font {
        .custom("SFProDisplay-Medium", size: size)
    }
    static func regular(_ size: CGFloat = 18) -> Font {
        .custom("SFProDisplay-Regular", size: size)
    }
    static func light(_ size: CGFloat = 18) -> Font {
        .custom("SFProDisplay-Light", size: size)
    }
    static func thin(_ size: CGFloat = 18) -> Font {
        .custom("SFProDisplay-Thin", size: size)
    }
}
