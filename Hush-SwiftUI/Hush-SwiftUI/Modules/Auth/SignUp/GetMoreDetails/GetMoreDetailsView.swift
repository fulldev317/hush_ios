//
//  GetMoreDetailsView.swift
//  Hush-SwiftUI
//
//  Created Dima Virych on 31.03.2020.
//  Copyright © 2020 AppServices. All rights reserved.
//

import SwiftUI
import PartialSheet

struct GetMoreDetailsView<ViewModel: GetMoreDetailsViewModeled>: View, AuthAppScreens {
    
    // MARK: - Properties
    
    @Environment(\.presentationMode) var mode
    @ObservedObject var viewModel: ViewModel
    @EnvironmentObject var app: App

    @State private var size: CGSize = .zero
    @State private var birth: String = "Enter your Date of Birth"
    @State private var country: String = "Select your country"
    @State var isShowing: Bool = false
    //@State var showLocation: Bool = false
    
    // MARK: - Lifecycle
    
    var body: some View {
        
        ZStack {
            ScrollView {
                content()
                .overlay(onBackButton(mode))
            }.keyboardAdaptive()
                .padding(.top, ISiPhoneX ? 0 : self.viewModel.editingLocation ? SCREEN_HEIGHT == 568 ? -170 : -80 : 0)
            
            HushIndicator(showing: self.isShowing)
            
            NavigationLink(destination: RootTabBarView(viewModel: RootTabBarViewModel()), isActive: self.$app.logedIn, label: { Text("") })
        }.background(background(name: "back1"))
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
                self.viewModel.hasErrorMessage = false
                self.viewModel.errorMessage = ""
            } )
                .padding(.horizontal, 16)
                .overlay(RoundedRectangle(cornerRadius: 6).stroke(Color.white, lineWidth: 1).frame(height: 48)).padding(.vertical)
                        
            if self.viewModel.editingLocation {
                LocationQuerySelectorView(provider: SelectLocationAPI(query: self.viewModel.location) { newLocation in
                    if let result = newLocation {
                        self.viewModel.location = result
                        self.viewModel.hasErrorMessage = false
                        self.viewModel.errorMessage = ""
                        self.viewModel.getGeoCode(address: result)
                    }
                    self.viewModel.editingLocation = true
                    
                }, editingLocation: self.$viewModel.editingLocation)
            } else {
                HStack {
                    
                    Spacer()
                    Text(self.viewModel.location.count == 0 ? "Type your city" : self.viewModel.location)
                    .font(.regular())
                    .foregroundColor(Color(UIColor.white))
                    .onTapGesture {
                        self.viewModel.editingLocation = true
                        self.viewModel.location = ""
                    }
                    Spacer()
                }
                .padding(.horizontal, 16)
                .overlay(RoundedRectangle(cornerRadius: 6).stroke(Color.white, lineWidth: 1).frame(height: 48)).padding(.vertical).padding(.bottom, 10)
                                       
            }
            
            pickers
            
            if viewModel.hasErrorMessage {
                HStack {
                    Text(viewModel.errorMessage).font(.thin()).foregroundColor(.hOrange)
                }.padding(.horizontal, 36)
                
            }
            
            borderedButton(action: {
                //self.app.logedIn = true
                self.viewModel.hasErrorMessage = false
                self.viewModel.errorMessage = ""
                
                if (self.birth == "Enter your Date of Birth") {
                    self.viewModel.hasErrorMessage = true
                    self.viewModel.errorMessage = "Enter your Date of Birth"
                    return
                }
                if (self.viewModel.location.count == 0) {
                    self.viewModel.hasErrorMessage = true
                    self.viewModel.errorMessage = "Type your City"
                    return
                }
                if (self.viewModel.latitude.count == 0 || self.viewModel.longitude.count == 0) {
                    self.viewModel.hasErrorMessage = true
                    self.viewModel.errorMessage = "Type your City"
                    return
                }
                
                self.isShowing = true

                self.viewModel.signup(birth: self.birth, result: { result in
                    self.isShowing = false
                    if (result) {
                        self.app.loadingData = true
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
            GetMoreDetailsView(viewModel: GetMoreDetailsViewModel(name: "", username: "", email: "", password: "", image: UIImage(), imagePath: "", imageThumb: "")).withoutBar()
        }.previewEnvironment()
    }
}
