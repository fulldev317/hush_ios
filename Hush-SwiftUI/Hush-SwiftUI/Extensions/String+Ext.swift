//
//  String+Ext.swift
//  Hush-SwiftUI
//
//  Created by fulldev on 7/28/20.
//  Copyright © 2020 AppServices. All rights reserved.
//

import SwiftUI

extension String {
    
    func parseSpecialText() -> String {
        return self.replacingOccurrences(of: "&#039;", with: "'")
    }
}
