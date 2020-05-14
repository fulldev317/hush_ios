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
    let onimage: (UIImage) -> Void
    
    @State private var text: String = ""
    @State private var height: CGFloat = 40
    @EnvironmentObject private var modalPresenterManager: ModalPresenterManager
    private let imagePicker = DVImagePicker()
    
    var body: some View {
        HStack {
            HapticButton(action: {
                self.imagePicker.showActionSheet(from: self.modalPresenterManager.presenter!) { result in
                    guard case let .success(image) = result else { return }
                    self.onimage(image)
                }
            }) {
                Image("send_photo")
                    .renderingMode(.template)
                    .foregroundColor(.white)
                    .padding()
            }
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
            }.disabled(text.isEmpty)
        }
        .frame(height: height)
        .background(Color(0x4F4F4F).cornerRadius(8))
    }
}

struct SendTextField_Previews: PreviewProvider {
    static var previews: some View {
        SendTextField(placeholder: "SAD", onsend: {_ in}, onimage: {_ in}).previewLayout(.sizeThatFits)
    }
}
