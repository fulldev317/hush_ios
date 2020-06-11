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
    @State private var birth: String = "Enter your Date of Birth"
    @State var isShowing: Bool = false

    // MARK: - Lifecycle
    
    var body: some View {
        
        ZStack {
            ScrollView {
                content()
                .overlay(onBackButton(mode))
            }.keyboardAdaptive()
            
            VStack {
                Text("Loading...")
                ActivityIndicator(isAnimating: .constant(true), style: .large)
            }
            .frame(width: 100,
                   height: 100)
            .background(Color.secondary.colorInvert())
            .foregroundColor(Color.primary)
            .cornerRadius(20)
            .opacity(self.isShowing ? 1 : 0)
            
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
            
            DatePickerField(text: $birth, picked: { date in
                self.$viewModel.birthday.wrappedValue = date
                self.$birth.wrappedValue = date
            } )
                .padding(.horizontal, 16)
                .overlay(RoundedRectangle(cornerRadius: 6).stroke(Color.white, lineWidth: 1).frame(height: 48)).padding(.vertical)
            HStack {
                CustomTextField(
                    placeholder: Text("Country").foregroundColor(Color(0x8E8786)).font(.regular(18)),
                    text: $viewModel.country
                )
                CustomTextField(
                   placeholder: Text("City").foregroundColor(Color(0x8E8786)).font(.regular(18)),
                   text: $viewModel.city
                )
            }
           
            pickers
            
            if viewModel.hasErrorMessage {
                HStack {
                    Text(viewModel.errorMessage).font(.thin()).foregroundColor(.hOrange)
                }.padding(.horizontal, 36)
                
            }
            
            borderedButton(action: {
                //self.app.logedIn = true
                self.isShowing = true

                self.viewModel.signup(birth: self.birth, result: { result in
                    self.isShowing = false
                    if (result) {
                        self.app.logedIn.toggle()
                    }
                })
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
                HSegmentedControl(selected: $viewModel.selectedLookingFors, list: viewModel.lookingFors)
            }
            
            VStack(spacing: 8) {
                Text("Finally, tell us what are you here for?").font(.thin()).foregroundColor(.white)
                HSegmentedControl(selected: $viewModel.selectedWhatFor, list: viewModel.whatFors)
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
