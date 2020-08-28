//
//  DiscoveriesSettingsViewModeled.swift
//  Hush-SwiftUI
//
//  Created Dima Virych on 02.04.2020.
//  Copyright © 2020 AppServices. All rights reserved.
//

import Combine

enum Gender: String, CaseIterable {
    case male
    case female
    case couple
    case gay
    //case everyone
    
    var title: String { rawValue.capitalized }
    static let allTitles = allCases.map { $0.title }
}

enum Sex: String, CaseIterable {
    case gay
    case open
    case straight
    case bisexual
    
    var title: String {
        if (rawValue == "open") {
            return "Open-Mind"
        }
        return rawValue.capitalized
    }
    static func typeForTitle(title: String) -> String {
        if (title == "open-mind") {
            return "open"
        }
        return title
    }
    static let allTitles = allCases.map { $0.title }
}

enum Living: String, CaseIterable {
    case alone
    case parent
    case partner
    case student
    
    var title: String {
        if (rawValue == "alone") {
            return "Alone"
        } else if (rawValue == "parent") {
            return "With parents"
        } else if (rawValue == "partner") {
            return "With partner"
        } else if (rawValue == "student") {
            return "Student house"
        }
        return rawValue.capitalized
    }
    static func typeForTitle(title: String) -> String {
        if (title == "alone") {
            return "alone"
        } else if (title == "with parents") {
            return "parent"
        } else if (title == "with partner") {
            return "partner"
        } else if (title == "student house") {
            return "student"
        }
        return "alone"
    }
    static let allTitles = allCases.map { $0.title }
}

protocol DiscoveriesSettingsViewModeled: ObservableObject {
    var lookingFors: [String] { get set }
    var selectedLookingFors: Set<Int> { get set }
    var gender: Gender { get set }
    var message: String { get set }
    var looking: String { get set }
    var dragFlag: Bool { get set }
    var location: String { get set }
    var selectedDistance : Double { get set }
    var ageSelLower: Double { get set }
    var ageSelUpper: Double { get set }
    var closeAPISelectorCompletion: (() -> Void)? { get set }
    
    func updateMessage()
    func saveLookingFor()
    func setLookingUI()
}
