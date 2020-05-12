//
//  TextQueryAPIProvider.swift
//  Hush-SwiftUI
//
//  Created by Serge Vysotsky on 12.05.2020.
//  Copyright © 2020 AppServices. All rights reserved.
//

import Foundation

protocol TextQueryAPIProvider: ObservableObject {
    var inputTitle: String { get }
    var query: String { get set }
    var searchResult: String { get }
    func select(_ result: String)
    func close()
}
