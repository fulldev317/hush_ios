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
    var name: String
    var username: String
    var email: String
    var password: String
       
    init(name: String, username: String, email: String, password: String, fromProfile: Bool) {
        self.name = name
        self.username = username
        self.email = email
        self.password = password
        self.fromProfile = fromProfile
    }
        
    let maskCategories = MaskCategory.allCases
    
    @Published var visibleCategories: [MaskCategory] = Array(MaskCategory.allCases[..<3])
    @Published var selectedCategory: MaskCategory?
    @Published var mask: Mask?
    @Published var fromProfile: Bool? = false
    
    @Published var shouldTakeImage: Bool = false
    @Published var capturedImage: UIImage?
    
    var canGoNextCategories: Bool { visibleCategories.last != maskCategories.last }
    var canGoPreviousCategories: Bool { visibleCategories.first != maskCategories.first }
    var pub: AnyCancellable!

    private var disposals = Set<AnyCancellable>()
    
    func reset() {
        mask = nil
        selectedCategory = nil
    }
    
    func done(selectedImage: Binding<UIImage?>) {
//        pub = $capturedImage.sink { (image) in
//            if image == nil {
//                selectedImage.wrappedValue = UIImage()
//            } else {
//                selectedImage.wrappedValue = image
//            }
//        }
        
        shouldTakeImage = true
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
        mask = Mask(name: name, category: selectedCategory!)
        selectedCategory = nil
    }
    
    func selectCategory(_ category: MaskCategory) {
        if selectedCategory == category {
            selectedCategory = nil
        } else {
            selectedCategory = category
        }
    }
}
