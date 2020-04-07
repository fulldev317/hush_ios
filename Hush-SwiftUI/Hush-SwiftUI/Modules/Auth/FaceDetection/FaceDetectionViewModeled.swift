//
//  FaceDetectionViewModeled.swift
//  Hush-SwiftUI
//
//  Created Dima Virych on 01.04.2020.
//  Copyright © 2020 AppServices. All rights reserved.
//

import Combine
import SwiftUI

protocol FaceDetectionViewModeled: ObservableObject {
    
    var message: String { get set }
    var size: CGFloat { get }
    var mainCategroyImageArr: [Image] { get }
    var mainCategroyOneImageArr: [Image] { get }
    var mainCategroyTwoImageArr: [Image] { get }
    var mainCategroyThreeImageArr: [Image] { get }
    var mainCategroyFourImageArr: [Image] { get }
    var expandedIndex: Int? { get }
    func updateMessage()
    func select(at index: Int)
}
