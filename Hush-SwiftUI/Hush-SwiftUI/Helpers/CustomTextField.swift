//
//  CustomTextField.swift
//  Hush-SwiftUI
//
//  Created by fulldev on 6/9/20.
//  Copyright © 2020 AppServices. All rights reserved.
//

import SwiftUI

struct CustomTextField: View {
    var placeholder: Text
    @Binding var text: String
    var editingChanged: (Bool)->() = { _ in }
    var commit: ()->() = { }

    var body: some View {
        ZStack(alignment: .center) {
            if text.isEmpty { placeholder }
            TextField("", text: $text, onEditingChanged: editingChanged, onCommit: commit)
                .multilineTextAlignment(.center)
            .font(.regular(17)).foregroundColor(.white)
            .padding(.horizontal, 16)
            .overlay(RoundedRectangle(cornerRadius: 6).stroke(Color.white, lineWidth: 1).frame(height: 48)).padding(.vertical)
        }
    }
}
