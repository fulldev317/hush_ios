//
//  StoriesSettingsViewModel.swift
//  Hush-SwiftUI
//
//  Created by Serge Vysotsky on 12.05.2020.
//  Copyright © 2020 AppServices. All rights reserved.
//

import Foundation

class StoriesSettingsViewModel: StoriesSettingsViewModeled {
    @Published var username = "Username"
    @Published var location = ""
    @Published var gender = Gender.male
    @Published var maxDistance = 1.0
    @Published var ageMin = 0.0
    @Published var ageMax = 1.0
    @Published var onlineUsers = true
    @Published var closeAPISelectorCompletion: (() -> Void)?
    
}
