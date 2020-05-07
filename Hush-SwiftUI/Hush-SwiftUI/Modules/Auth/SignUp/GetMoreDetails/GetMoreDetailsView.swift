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
            Text("Date of Birth")
                .font(.thin())
                .foregroundColor(.white)
            DatePickerField(text: $viewModel.birthday)
                .padding(.horizontal, 16)
                .overlay(RoundedRectangle(cornerRadius: 6).stroke(Color.white, lineWidth: 1).frame(height: 48)).padding(.vertical)
                
            pickers
            
            borderedButton(action: {
                self.app.logedIn = true
            }, title: "Submit").padding(.bottom, 55)
        }.padding(.horizontal, 30)
    }
    
    var pickers: some View {
        Group {
            Text("How do you describe yourself?").font(.thin()).foregroundColor(.white)
            HSegmentedControl(selected: $viewModel.selectedGender, list: viewModel.genders)
                .padding(.bottom, 16)
            
            Text("Would like to meet new").font(.thin()).foregroundColor(.white)
            HSegmentedControl(selected: $viewModel.selectedLookingFors, list: viewModel.lookingFors)
                .padding(.bottom, 28)
            
            Text("Finally, tell us what are you here for?").font(.thin()).foregroundColor(.white)
            HSegmentedControl(selected: $viewModel.selectedWhatFor, list: viewModel.whatFors)
                .padding(.bottom, 28)
        }
    }
}

struct GetMoreDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            NavigationView {
                GetMoreDetailsView(viewModel: GetMoreDetailsViewModel()).withoutBar()
            }
            NavigationView {
                GetMoreDetailsView(viewModel: GetMoreDetailsViewModel()).withoutBar()
            }.previewDevice(.init(rawValue: "iPhone SE"))
            NavigationView {
                GetMoreDetailsView(viewModel: GetMoreDetailsViewModel()).withoutBar()
            }.previewDevice(.init(rawValue: "iPhone 8"))
            NavigationView {
                GetMoreDetailsView(viewModel: GetMoreDetailsViewModel()).withoutBar()
            }.previewDevice(.init(rawValue: "iPhone XS Max"))
        }.environmentObject(App())
    }
}
