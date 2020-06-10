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
    @EnvironmentObject var app: App

    @State private var size: CGSize = .zero
    
    
    // MARK: - Lifecycle
    
    var body: some View {
        ZStack {
            ScrollView {
                content()
                .overlay(onBackButton(mode))
            }.keyboardAdaptive()
            NavigationLink(destination: RootTabBarView(viewModel: RootTabBarViewModel()), isActive: self.$app.logedIn, label: { Text("") })
        }.background(background())
    }
    
    private func content() -> some View {
        VStack {
            logo()
                .padding(.vertical, 35)
            Text("Please tell us a little more about you")
                .font(.thin())
                .foregroundColor(.white)
                .padding(.bottom, 20)

            DatePickerField(text: $viewModel.birthday, picked: { date in
                self.$viewModel.birthday.wrappedValue = date
                
            } )
                .padding(.horizontal, 16)
                .overlay(RoundedRectangle(cornerRadius: 6).stroke(Color.white, lineWidth: 1).frame(height: 48)).padding(.vertical)
            
            CustomTextField(
                placeholder: Text("Enter your Location").foregroundColor(.white).font(.regular(18)),
                text: $viewModel.location
            )
//            ZStack {
//
//                TextField("Enter your Location", text: $viewModel.location).font(.regular(17)).foregroundColor(.white)
//                    .padding(.horizontal, 16)
//                    .overlay(RoundedRectangle(cornerRadius: 6).stroke(Color.white, lineWidth: 1).frame(height: 48)).padding(.vertical)
            
 //           }
            pickers
            borderedButton(action: {
                self.app.logedIn = true
                //self.viewModel.signup()
            }, title: "Submit").padding(.bottom, 55)
        }.padding(.horizontal, 30)
    }
    
    var pickers: some View {
        VStack(spacing: 20) {
            VStack(spacing: 8) {
                Text("How do you describe yourself?").font(.thin()).foregroundColor(.white)
                HSegmentedControl(selected: $viewModel.selectedGender, list: viewModel.genders)
            }
            
            VStack(spacing: 8) {
                Text("Would like to meet new").font(.thin()).foregroundColor(.white)
                HSegmentedControl(selectedList: $viewModel.selectedLookingFors, list: viewModel.lookingFors)
            }
            
            VStack(spacing: 8) {
                Text("Finally, tell us what are you here for?").font(.thin()).foregroundColor(.white)
                HSegmentedControl(selectedList: $viewModel.selectedWhatFor, list: viewModel.whatFors)
            }
        }.padding(.bottom, 30)
    }
}

struct GetMoreDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            GetMoreDetailsView(viewModel: GetMoreDetailsViewModel(name: "", username: "", email: "", password: "", image: UIImage())).withoutBar()
        }.previewEnvironment()
    }
}
