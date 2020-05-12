//
//  SelectLocationAPI.swift
//  Hush-SwiftUI
//
//  Created by Serge Vysotsky on 12.05.2020.
//  Copyright © 2020 AppServices. All rights reserved.
//

import Combine

class SelectLocationAPI: TextQueryAPIProvider {
    let inputTitle = "Type your city"
    @Published var query = ""
    @Published var searchResult = ""
    
    private let completion: (String?) -> Void
    
    private let locations = [
        "London, England, United Kingdom",
        "Palo Alto, California, United States",
        "Los Angeles, California, United States",
    ]
    
    private var disposals = [AnyCancellable]()
    init(completion: @escaping (String?) -> Void) {
        self.completion = completion
        subscribe()
    }
    
    func select(_ result: String) {
        completion(result)
    }
    
    func close() {
        completion(nil)
    }
    
    func subscribe() {
        $query.map { [unowned self] query in
            self.locations.first { location in
                location.lowercased().contains(query.lowercased())
            } ?? String()
        }.assign(to: \.searchResult, on: self)
        .store(in: &disposals)
    }
}
