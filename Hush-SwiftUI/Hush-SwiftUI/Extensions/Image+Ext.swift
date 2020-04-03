//
//  Image+Ext.swift
//  Hush-SwiftUI
//
//  Created by Dima Virych on 03.04.2020.
//  Copyright © 2020 AppServices. All rights reserved.
//

import SwiftUI

extension Image {
    
    func aspectRatio(_ mode: ContentMode = .fill) -> some View {
        resizable().aspectRatio(contentMode: mode)
    }
}
