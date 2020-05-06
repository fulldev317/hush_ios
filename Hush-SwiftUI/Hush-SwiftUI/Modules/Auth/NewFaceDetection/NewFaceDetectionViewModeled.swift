//
//  NewFaceDetectionViewModeled.swift
//  Hush-SwiftUI
//
//  Created by Serge Vysotsky on 04.05.2020.
//  Copyright © 2020 AppServices. All rights reserved.
//

import SwiftUI

enum MaskCategory: Int, CaseIterable {
    case ball
    case funny
    case glasses
    case ancient
    
    var categoryImage: String {
        switch self {
        case .ball: return "12"
        case .funny: return "13"
        case .glasses: return "6"
        case .ancient: return "19"
        }
    }
    
    var categoryImages: [String] {
        switch self {
        case .ball: return ["7","8","9","10","11","12"]
        case .funny: return ["13","14","15","16","17","18"]
        case .glasses: return ["1","2","3","4","5","6"]
        case .ancient: return ["19","20","21","22","23","24"]
        }
    }
}

struct Mask {
    let name: String
    let category: MaskCategory
    
    var image: UIImage {
        UIImage(named: name)!
    }
}

protocol NewFaceDetectionViewModeled: ObservableObject {
    var mask: Mask? { get set }
    var maskCategories: [MaskCategory] { get }
    var visibleCategories: [MaskCategory] { get }
    var selectedCategory: MaskCategory? { get set }
    
    var shouldTakeImage: Bool { get set }
    var capturedImage: UIImage? { get set }
    
    var canGoNextCategories: Bool { get }
    var canGoPreviousCategories: Bool { get }
    
    func nextCategories()
    func previousCategories()
    
    func reset()
    func done()
    
    func selectMask(_ name: String)
}
