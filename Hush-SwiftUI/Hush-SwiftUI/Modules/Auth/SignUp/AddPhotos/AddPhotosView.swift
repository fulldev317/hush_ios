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
    
    // MARK: - Lifecycle
    
    var body: some View {
        ZStack {
            VStack(spacing: 30) {
                logo()
                    .padding(.top, 55)
                Text("Add a Photo")
                    .font(.thin(22))
                    .foregroundColor(.white)
                Text(viewModel.messageLabel)
                    .font(.thin())
                    .foregroundColor(.hOrange)
                    .multilineTextAlignment(.center)
                borderedButton(action: viewModel.addPhoto, title: "Add a Photo")
                    .padding(.horizontal, 30)
                Spacer()
            }
            onBackButton(mode)
            NavigationLink(destination: FaceDetectionView(viewModel: FaceDetectionViewModel()),
                           isActive: $viewModel.canGoNext, label: EmptyView.init)
            
            NavigationLink(destination: PermissionDeniedView(type: viewModel.pickerSourceType),
                           isActive: $viewModel.isPermissionDenied, label: EmptyView.init)
        }.background(background()).navigationBarHidden(true)
        .actionSheet(isPresented: $viewModel.isPickerSheetPresented) {
            ActionSheet(title: Text("Provide a context for the actions."), message: nil, buttons: [
                .default(Text("Take a Photo"), action: viewModel.takePhoto),
                .default(Text("Camera Roll"), action: viewModel.cameraRoll),
                .cancel()
            ])
        }
        .sheet(isPresented: $viewModel.isPickerPresented) {
            ImagePickerView(
                source: self.viewModel.pickerSourceType,
                image: self.$viewModel.selectedImage,
                isPresented: self.$viewModel.isPickerPresented)
        }
        .onAppear(perform: viewModel.appear)
        .onDisappear(perform: viewModel.disappear)
    }
}

struct AddPhotosView_Previews: PreviewProvider {
    private static let picker = DVImagePicker()
    static var previews: some View {
        NavigationView {
            AddPhotosView(viewModel:  AddPhotosViewModel())
                .withoutBar()
        }
    }
}
