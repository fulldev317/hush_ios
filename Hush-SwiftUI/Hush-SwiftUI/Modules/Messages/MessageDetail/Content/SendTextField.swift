//
//  SendTextField.swift
//  Hush-SwiftUI
//
//  Created by Dima Virych on 06.04.2020.
//  Copyright © 2020 AppServices. All rights reserved.
//

import SwiftUI

struct SendTextField: View {
    
    let placeholder: String
    let onsend: (String) -> Void
    
    @State private var text: String = ""
    @State private var height: CGFloat = 40
    
    var body: some View {
        HStack {
            MultilineTextField(placeholder, text: $text, height: $height)
                .padding(.vertical, 20)
                .foregroundColor(.white)
            HapticButton(action: {
                self.onsend(self.text)
                self.text = ""
            }) {
                Image("paperplane")
                    .renderingMode(.template)
                    .foregroundColor(.white)
                    .padding()
            }
        }
        .padding(.leading, 15)
        .frame(height: height)
        .background(Color(0x4F4F4F).cornerRadius(8))
    }
}

struct SendTextField_Previews: PreviewProvider {
    static var previews: some View {
        SendTextField(placeholder: "SAD", onsend: {_ in}).previewLayout(.sizeThatFits)
    }
}
