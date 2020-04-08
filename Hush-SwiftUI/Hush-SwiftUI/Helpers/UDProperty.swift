//
//  UDProperty.swift
//  FeedStoreChallenge
//
//  Created by Dima Virych on 01.02.2020.
//  Copyright © 2020 Essential Developer. All rights reserved.
//

import Foundation

@propertyWrapper
public struct UDProperty<Value: Codable> {
    
    let defaults: UserDefaults = .standard
    let key: String
    
    public var wrappedValue: Value? {
        get { getValue() }
        set { set(newValue)}
    }
    
    private func getValue() -> Value? {
        
        guard let data = defaults.data(forKey: key) else {
            return nil
        }
        
        return try? JSONDecoder().decode(Value.self, from: data)
    }
    
    private func set(_ value: Value?) {
        defaults.set(try? JSONEncoder().encode(value), forKey: key)
    }
}
