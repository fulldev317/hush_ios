//
//  AppearenceModifier.swift
//  Hush-SwiftUI
//
//  Created by Serge Vysotsky on 10.05.2020.
//  Copyright © 2020 AppServices. All rights reserved.
//

import SwiftUI

struct AppearenceModifier<Appearence: UIAppearance, Value>: ViewModifier {
    let path: ReferenceWritableKeyPath<Appearence, Value>
    let value: Value
    private let savedValue: Value
    
    init(path: ReferenceWritableKeyPath<Appearence, Value>, value: Value) {
        savedValue = Appearence.appearance()[keyPath: path]
        self.value = value
        self.path = path
    }
    
    func body(content: Content) -> some View {
        content.onAppear {
            Appearence.appearance()[keyPath: self.path] = self.value
        }.onDisappear {
            Appearence.appearance()[keyPath: self.path] = self.savedValue
        }
    }
}

extension View {
    func appearenceModifier<Appearence: UIAppearance, Value>(path: ReferenceWritableKeyPath<Appearence, Value>, value: Value) -> some View {
        modifier(AppearenceModifier(path: path, value: value))
    }
}
