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
    let maskCategoriesImages = [["19", "13", "6"], ["12"]]
    let images: [[[String]]] = {
        [[["19","20","21"], ["22","23","24"]],
         [["13","14","15"], ["16","17","18"]],
         [["1","2","3"], ["4","5","6"]],
         [["7","8","9"], ["10","11","12"]]]
    }()
    
    @Published var maskImage: UIImage?
    @Published var maskOpacity: CGFloat = 0
    
    var size: CGFloat {
        (UIScreen.main.bounds.width - 120) / 3
    }
}
