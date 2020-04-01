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
                Spacer()
                logo()
                Text("Add a Photo")
                    .font(.thin(22))
                    .foregroundColor(.white)
                Text(viewModel.messageLabel)
                    .font(.thin())
                    .foregroundColor(.hOrange)
                    .multilineTextAlignment(.center)
                borderedButton(action: viewModel.addPhotoPressed, title: "Add a Photo").padding(.horizontal, 30)
                Spacer()
                Spacer()
            }
            onBackButton(mode)
            NavigationLink(destination: GetMoreDetailsView(viewModel: GetMoreDetailsViewModel()).withoutBar(), isActive: $viewModel.canGoNext) {
                Text("")
            }
            }.background(bluredBackground()).navigationBarHidden(true)
    }
}

struct AddPhotosView_Previews: PreviewProvider {
    private static let picker = DVImagePicker()
    static var previews: some View {
        Group {
            NavigationView {
                AddPhotosView(viewModel:  AddPhotosViewModel(picker)).withoutBar()
            }.previewDevice(.init(rawValue: "iPhone XS Max"))
            NavigationView {
                AddPhotosView(viewModel:  AddPhotosViewModel(picker)).withoutBar()
            }.previewDevice(.init(rawValue: "iPhone 8"))
            NavigationView {
                AddPhotosView(viewModel:  AddPhotosViewModel(picker)).withoutBar()
            }.previewDevice(.init(rawValue: "iPhone SE"))
        }
    }
}
