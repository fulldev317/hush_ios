//
//  NewFaceDetectionViewModeled.swift
//  Hush-SwiftUI
//
//  Created by Serge Vysotsky on 04.05.2020.
//  Copyright © 2020 AppServices. All rights reserved.
//

import SwiftUI

protocol NewFaceDetectionViewModeled: ObservableObject {
    var maskImage: UIImage? { get set }
    var maskOpacity: CGFloat { get set }
    var images: [[[String]]] { get }
    var maskCategoriesImages: [[String]] { get }
}
