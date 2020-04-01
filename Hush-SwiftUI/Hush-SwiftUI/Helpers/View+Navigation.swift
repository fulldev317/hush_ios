//
//  View+Navigation.swift
//  Hush-SwiftUI
//
//  Created by Dima Virych on 01.04.2020.
//  Copyright © 2020 AppServices. All rights reserved.
//

import SwiftUI

extension View {
    
    func withoutBar() -> some View {
        self.navigationBarTitle("", displayMode: .inline).navigationBarHidden(true)
    }
}
