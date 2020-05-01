//
//  AddPhotosView.swift
//  Hush-SwiftUI
//
//  Created Dima Virych on 31.03.2020.
//  Copyright © 2020 AppServices. All rights reserved.
//

import SwiftUI

struct AddPhotosView<ViewModel: AddPhotosViewModeled>: View, AuthAppScreens {

    // MARK: - Properties
    
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    
    @ObservedObject var viewModel: ViewModel
    
    @State private var pickerSheetPresented = false
    @State private var cameraPickerPresented = false
    @State private var libraryPickerPresented = false
    
    // MARK: - Lifecycle
    
    var body: some View {
        ZStack {
            VStack(spacing: 30) {
                Spacer()
                logo()
                Text("Add a Photo")
                    .font(.thin(22))
                    .foregroundColor(.white)
                Text(viewModel.messageLabel)
                    .font(.thin())
                    .foregroundColor(.hOrange)
                    .multilineTextAlignment(.center)
                borderedButton(action: { self.pickerSheetPresented = true }, title: "Add a Photo").padding(.horizontal, 30)
                Spacer()
                Spacer()
            }
            onBackButton(mode)
            NavigationLink(destination: FaceDetectionView(viewModel: FaceDetectionViewModel()), isActive: $viewModel.canGoNext) {
                Text("")
            }
        }.background(background()).navigationBarHidden(true)
        .actionSheet(isPresented: $pickerSheetPresented) {
            ActionSheet(title: Text("Provide a context for the actions."), message: nil, buttons: [
                .default(Text("Take a Photo")) { self.cameraPickerPresented = true },
                .default(Text("Camera Roll")) { self.libraryPickerPresented = true },
                .cancel()
            ])
        }
        .sheet(isPresented: .constant(libraryPickerPresented || cameraPickerPresented)) {
            ImagePickerView(
                source: self.libraryPickerPresented ? .photoLibrary : .camera,
                image: self.$viewModel.selectedImage,
                isPresented: self.libraryPickerPresented ? self.$libraryPickerPresented : self.$cameraPickerPresented)
        }
    }
}

struct AddPhotosView_Previews: PreviewProvider {
    private static let picker = DVImagePicker()
    static var previews: some View {
        Group {
            NavigationView {
                AddPhotosView(viewModel:  AddPhotosViewModel()).withoutBar()
            }.previewDevice(.init(rawValue: "iPhone XS Max"))
            NavigationView {
                AddPhotosView(viewModel:  AddPhotosViewModel()).withoutBar()
            }.previewDevice(.init(rawValue: "iPhone 8"))
            NavigationView {
                AddPhotosView(viewModel:  AddPhotosViewModel()).withoutBar()
            }.previewDevice(.init(rawValue: "iPhone SE"))
        }
    }
}
