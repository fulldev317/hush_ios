//
//  ImagePickerView.swift
//  Hush-SwiftUI
//
//  Created by Serge Vysotsky on 01.05.2020.
//  Copyright © 2020 AppServices. All rights reserved.
//

import SwiftUI

struct ImagePickerView: UIViewControllerRepresentable {
    let source: UIImagePickerController.SourceType
    @Binding var image: UIImage?
    @Binding var isPresented: Bool

    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.sourceType = source
        picker.delegate = context.coordinator
        return picker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {

    }

    func makeCoordinator() -> Coordinator {
        Coordinator(isPresented: $isPresented, selectedImage: $image)
    }

    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        @Binding var isPresented: Bool
        @Binding var selectedImage: UIImage?

        init(isPresented: Binding<Bool>, selectedImage: Binding<UIImage?>) {
            _isPresented = isPresented
            _selectedImage = selectedImage
        }

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            selectedImage = info[.originalImage] as? UIImage
            isPresented = false
        }

        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            isPresented = false
        }
    }
}


struct ImagePickerView_Previews: PreviewProvider {
    static var previews: some View {
        ImagePickerView(source: .photoLibrary, image: .constant(nil), isPresented: .constant(false))
    }
}
