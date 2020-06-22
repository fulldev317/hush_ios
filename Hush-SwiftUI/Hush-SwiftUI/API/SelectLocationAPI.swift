//
//  SelectLocationAPI.swift
//  Hush-SwiftUI
//
//  Created by Serge Vysotsky on 12.05.2020.
//  Copyright © 2020 AppServices. All rights reserved.
//

import Combine

class SelectLocationAPI: TextQueryAPIProvider {
    var inputTitle = "Type your city"
    @Published var query = ""
    @Published var searchResult = ""
    @Published var searchData = ""

    private let completion: (String?) -> Void
    
    private let locations = [
        "London, England, United Kingdom",
        "Palo Alto, California, United States",
        "Los Angeles, California, United States",
    ]
    
    private var disposals = [AnyCancellable]()
    init(query: String, completion: @escaping (String?) -> Void) {
        self.query = query
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
            AuthAPI.shared.get_address(query: query) { address in
                self.searchResult = address!
            }
            return self.locations.first { location in
                location.lowercased().contains(query.lowercased())
            } ?? String()
        }.assign(to: \.searchData, on: self)
        .store(in: &disposals)
    }
}
