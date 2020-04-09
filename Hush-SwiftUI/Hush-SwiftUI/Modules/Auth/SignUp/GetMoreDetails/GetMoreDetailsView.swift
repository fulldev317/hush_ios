//
//  GetMoreDetailsView.swift
//  Hush-SwiftUI
//
//  Created Dima Virych on 31.03.2020.
//  Copyright © 2020 AppServices. All rights reserved.
//

import SwiftUI

struct GetMoreDetailsView<ViewModel: GetMoreDetailsViewModeled>: View, AuthAppScreens {
    
    // MARK: - Properties
    
    @Environment(\.presentationMode) var mode
    @ObservedObject var viewModel: ViewModel
    
    
    // MARK: - Lifecycle
    
    var body: some View {
        ZStack {
            background()
            
            ScrollView {
                content()
            }.keyboardAdaptive()
            onBackButton(mode)
        }
    }
    
    private func content() -> some View {
        VStack {
            logo()
                .padding(.vertical, 35)
            Text("Please tell us a little more about you")
                .font(.thin())
                .foregroundColor(.white)
                .padding(.bottom, 20)
            Text("Date of Birth")
                .font(.thin())
                .foregroundColor(.white)
            DatePickerField(text: $viewModel.birthday)
                .padding(.horizontal, 16)
                .overlay(RoundedRectangle(cornerRadius: 6).stroke(Color.white, lineWidth: 1).frame(height: 48)).padding(.vertical)
            Text("I am").font(.thin()).foregroundColor(.white)
            HSegmentedControl(selected: $viewModel.selectedGender, list: viewModel.genders).padding(.bottom, 16)
            Text("Looking for").font(.thin()).foregroundColor(.white)
            HSegmentedControl(selected: $viewModel.selectedLookingFors, list: viewModel.lookingFors)
                .padding(.bottom, 28)
            borderedButton(action: {}, title: "Submit").padding(.bottom, 55)
        }.padding(.horizontal, 30)
    }
}

struct GetMoreDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
//            NavigationView {
//                GetMoreDetailsView(viewModel: GetMoreDetailsViewModel())
//            }.previewDevice(.init(rawValue: "iPhone SE"))
            NavigationView {
                GetMoreDetailsView(viewModel: GetMoreDetailsViewModel())
            }.previewDevice(.init(rawValue: "iPhone 8"))
            NavigationView {
                GetMoreDetailsView(viewModel: GetMoreDetailsViewModel())
            }.previewDevice(.init(rawValue: "iPhone XS Max"))
        }
    }
}
