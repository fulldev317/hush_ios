//
//  View+Env.swift
//  Hush-SwiftUI
//
//  Created by Serge Vysotsky on 11.05.2020.
//  Copyright © 2020 AppServices. All rights reserved.
//

import SwiftUI
import PartialSheet

extension View {
    func previewEnvironment() -> some View {
        self
            .environmentObject(App())
            .environmentObject(PartialSheetManager())
    }
}
