//
//  HapticButton.swift
//  Hush-SwiftUI
//
//  Created by Dima Virych on 30.03.2020.
//  Copyright © 2020 AppServices. All rights reserved.
//

import SwiftUI

public struct HapticButton<Label: View>: View {
    
    private let label: Label
    private let action: () -> Void
    
    public init(action: @escaping () -> Void, @ViewBuilder label: () -> Label) {
        self.action = action
        self.label = label()
    }
    
    public var body: some View {
        
        Button(action: {
            self.feedback()
            self.action()
        }, label: {
            label
        })
    }
    
    func feedback() {
        
        UISelectionFeedbackGenerator().selectionChanged()
    }
}
