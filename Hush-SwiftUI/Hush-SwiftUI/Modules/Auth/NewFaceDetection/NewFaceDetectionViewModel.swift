//
//  NewFaceDetectionViewModel.swift
//  Hush-SwiftUI
//
//  Created by Serge Vysotsky on 04.05.2020.
//  Copyright © 2020 AppServices. All rights reserved.
//

import SwiftUI
import Combine

class NewFaceDetectionViewModel: NewFaceDetectionViewModeled {
    let maskCategories = MaskCategory.allCases
    
    @Published var visibleCategories: [MaskCategory] = Array(MaskCategory.allCases[..<3])
    @Published var selectedCategory: MaskCategory?
    @Published var maskImage: UIImage?
    
    @Published var shouldTakeImage: Bool = false
    @Published var capturedImage: UIImage?
    
    var canGoNextCategories: Bool { visibleCategories.last != maskCategories.last }
    var canGoPreviousCategories: Bool { visibleCategories.first != maskCategories.first }
    
    private var disposals = Set<AnyCancellable>()
    
    func reset() {
        maskImage = nil
        selectedCategory = nil
    }
    
    func done() {
        
    }
    
    func nextCategories() {
        guard canGoNextCategories else { return }
        let endIndex = maskCategories.endIndex
        let currentEndIndex = visibleCategories.count
        let nextEnd = maskCategories.index(currentEndIndex, offsetBy: 3, limitedBy: endIndex) ?? endIndex
        visibleCategories = Array(maskCategories[currentEndIndex..<nextEnd])
        selectedCategory = nil
    }
    
    func previousCategories() {
        guard canGoPreviousCategories else { return }
        let startIndex = maskCategories.startIndex
        let currentStartIndex = maskCategories.firstIndex(of: visibleCategories.first!)!
        let nextStart = maskCategories.index(currentStartIndex, offsetBy: -3, limitedBy: startIndex) ?? startIndex
        visibleCategories = Array(maskCategories[nextStart..<currentStartIndex])
        selectedCategory = nil
    }
    
    func selectMask(_ name: String) {
        maskImage = UIImage(named: name)
        selectedCategory = nil
    }
}
