//
//  StoriesSettingsViewModeled.swift
//  Hush-SwiftUI
//
//  Created by Serge Vysotsky on 12.05.2020.
//  Copyright © 2020 AppServices. All rights reserved.
//

import Foundation

protocol StoriesSettingsViewModeled: ObservableObject {
    var username: String { get set }
    var location: String { get set }
    var gender: Gender { get set }
    var maxDistance: Double { get set }
    var selectedDistance: Double { get set }

    var ageMin: Double { get set }
    var ageMax: Double { get set }
    var onlineUsers: Bool { get set }
    var closeAPISelectorCompletion: (() -> Void)? { get set }
    
    var genderDescription: String { get }
    var maxDistanceDescription: String { get }
    var ageMinDescription: String { get }
    var ageMaxDescription: String { get }
}

extension StoriesSettingsViewModeled {
    var genderDescription: String { gender.title }
    var maxDistanceDescription: String {
        let miles = 10 + maxDistance * 80
        let kilometers = miles * 1.6
        return String(format: "%.f Miles (%.fkm)", miles, kilometers)
    }
    var ageMinDescription: String { String(Int(ageMin * (99 - 18) + 18)) }
    var ageMaxDescription: String { String(Int(ageMax * (99 - 18) + 18)) }
}
