//
//  FaceDetectionViewModel.swift
//  Hush-SwiftUI
//
//  Created Dima Virych on 01.04.2020.
//  Copyright © 2020 AppServices. All rights reserved.
//

import SwiftUI
import Combine

class FaceDetectionViewModel: FaceDetectionViewModeled {
    
    // MARK: - Properties

    @Published var message = "Hellow World!"
    @Published private(set) var expandedIndex: Int?
    
    let mainCategroyImageArr = ["19","13","6","12"].map { Image($0) }
    let mainCategroyOneImageArr = ["19","20","21","22","23","24"].map { Image($0) }
    let mainCategroyTwoImageArr = ["13","14","15","16","17","18"].map { Image($0) }
    let mainCategroyThreeImageArr = ["1","2","3","4","5","6"].map { Image($0) }
    let mainCategroyFourImageArr = ["7","8","9","10","11","12"].map { Image($0) }
    var size: CGFloat {
        (UIScreen.main.bounds.width - 120) / 3
    }
    
    func updateMessage() {

        message = "New Message"
    }
    
    func select(at index: Int) {
        
        if self.expandedIndex == index {
            self.expandedIndex = nil
        } else {
            self.expandedIndex = index
        }
    }
}
