//
//  DeviceScale.swift
//  Hush-SwiftUI
//
//  Created by Serge Vysotsky on 14.05.2020.
//  Copyright © 2020 AppServices. All rights reserved.
//

import SwiftUI

struct DeviceScale: EnvironmentKey {
    static var defaultValue = UIScreen.main.bounds.width / 414
}

extension EnvironmentValues {
    var deviceScale: CGFloat {
        set { self[DeviceScale.self] = newValue }
        get { self[DeviceScale.self] }
    }
}
