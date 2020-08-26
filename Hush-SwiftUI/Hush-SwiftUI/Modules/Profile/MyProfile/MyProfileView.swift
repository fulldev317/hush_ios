//
//  MyProfileView.swift
//  Hush-SwiftUI
//
//  Created Dima Virych on 07.04.2020.
//  Copyright © 2020 AppServices. All rights reserved.
//

import SwiftUI
import PartialSheet

extension View {
    var centred: some View {
        HStack {
            Spacer()
            self
            Spacer()
        }
    }
}

struct MyProfileView<ViewModel: MyProfileViewModeled>: View, HeaderedScreen {
    
    // MARK: - Properties
    
    @ObservedObject var viewModel: ViewModel
    @EnvironmentObject var app: App
    @EnvironmentObject private var partialSheetManager: PartialSheetManager
    @State var showMatchesView = false
    @State var showVisitedMeView = false
    @State var showLikesMeView = false
    @State var showMyLikeView = false
    @State private var height: CGFloat = 50
    @State var isPhotoTapped = false
    @State var showAlert = false
    @State var alertMessage = ""
    @State var showUpgrade = false

    private let deviceScale = SCREEN_WIDTH / 411

    // MARK: - Lifecycle
    
    var body: some View {
        ZStack {
            ZStack(alignment: .top) {
                VStack(spacing: 0) {
                    HStack {
                        header([Text("My Profile")
                            .font(.ultraLight(48))
                            .foregroundColor(.hOrange)])
                            .padding(.bottom)
                        HapticButton(action: {
                            withAnimation {
                                self.app.onProfileEditing = !self.app.onProfileEditing
                            }
                        }) {
                            Text(self.app.onProfileEditing ? "Done" : "Edit")
                                .font(.regular(17))
                                .foregroundColor(Color.white)
                                .padding(.all)
                        }
                    }

                    ScrollView {
                        scrollContent
                    }.keyboardAdaptive()
                    
                    NavigationLink(destination: NewFaceDetection(viewModel: NewFaceDetectionViewModel(name: "", username: "", email: "", password: "", fromProfile: true), selectedImage: $viewModel.selectedImage, photoModel: AddPhotosViewModel(name: "", username: "", email: "", password: "")),
                        isActive: $viewModel.canGoToAR,
                        label: EmptyView.init)
                    
                    if (self.$showUpgrade.wrappedValue) {
                        NavigationLink(
                            destination: UpgradeView(viewModel: UpgradeViewModel(isMatched: false)).withoutBar().onDisappear(perform: {
                                if (Common.premium()) {
                                    self.viewModel.basicsViewModel.isPremium = "Yes"
                                } else {
                                    self.viewModel.basicsViewModel.isPremium = "Activate"
                                }
                            }),
                            isActive: self.$showUpgrade,
                            label: EmptyView.init
                        )
                    }
                }
            }.background(Color.hBlack.edgesIgnoringSafeArea(.all))
            
            HushIndicator(showing: self.viewModel.isShowingIndicator)

        }
    }
    
    var scrollContent: some View {
        
        VStack(alignment: .leading, spacing: ISiPhone5 ? 10 : 25) {

            self.carusel1(unlocked: self.$viewModel.unlockedPhotos, images: $viewModel.photoUrls)

            Text("\(viewModel.basicsViewModel.username), \(viewModel.basicsViewModel.age)")
                .font(.bold(28))
                .foregroundColor(.white)
                .centred
            if !app.onProfileEditing {
                premiumButton.animation(.spring())
                profileActivity.animation(.spring())
            }
            profileBasics
            if !app.onProfileEditing {
                notifications.animation(.spring())
                legal.animation(.spring())
            }
        }.padding(.vertical, 10 + SafeAreaInsets.bottom)
    }
    
    // MARK: - Carousel
    func carusel1(unlocked: Binding<Set<Int>>, images: Binding<[String]>) -> some View {
        VStack(alignment: .leading, spacing: 0) {
            ScrollView(.horizontal) {
                HStack(spacing: 15) {
                    ForEach(0 ..< MAX_PHOTOS) { index in
                        PhotoCard<EmptyView>(
                            image: index < images.wrappedValue.count ? images.wrappedValue[index] : "empty",
                            cardWidth: 92
                        )
                        .overlay(Color.black.opacity(unlocked.wrappedValue.contains(index) ? 0 : 0.7))
                        .rotationEffect(.degrees(index.isMultiple(of: 2) ? -5 : 5))
                        .onTapGesture {
                            self.viewModel.selectedIndex = index
                            self.viewModel.addPhoto()
                        }
                        .animation(.default)
                    }
                }.padding(.vertical, ISiPhone5 ? 5 : 15)
                    .padding(.horizontal, 5)
            }
            
        }.actionSheet(isPresented: $viewModel.isPickerSheetPresented) {
            ActionSheet(title: Text("Choose how to submit a photo"), message: nil, buttons: [
                .default(Text("Take a Photo"), action: viewModel.takePhoto),
                .default(Text("Camera Roll"), action: viewModel.cameraRoll),
                .cancel()
            ])
        }.sheet(isPresented: $viewModel.isPickerPresented) {
            ImagePickerView(
                source: self.viewModel.pickerSourceType,
                image: self.$viewModel.selectedImage,
                isPresented: self.$viewModel.isPickerPresented)
        }
        .onAppear(perform: viewModel.appear)
        .onDisappear(perform: viewModel.disappear)
    }
    
    // MARK: - Image
    var imagesView: some View {
        ZStack {
            HStack {
                PolaroidCard<EmptyView>(image: viewModel.selectedImage!, cardWidth: smallCardSize.width)
                    .rotationEffect(.degrees(5))
                Spacer()
                PolaroidCard<EmptyView>(image: viewModel.selectedImage!, cardWidth: smallCardSize.width).rotationEffect(.degrees(5))
                
            }.padding(.horizontal, 37)
            PolaroidCard(image: viewModel.selectedImage!, cardWidth: bigCardSize.width, bottom:
                HStack {
                    Spacer()
                    HapticButton(action: {}, label: {
                        Image("editProfile_icon")
                            .aspectRatio(.fit)
                            .frame(width: 25, height: 25)
                            .padding(.trailing, 20)
                            .foregroundColor(Color(0xE0E0E0))
                    })
                }
                .frame(height: bigCardSize.height - bigCardSize.width))
            .rotationEffect(.degrees(-5))
            .onTapGesture {
                self.viewModel.addPhoto()
            }
        }.actionSheet(isPresented: $viewModel.isPickerSheetPresented) {
            ActionSheet(title: Text("Choose how to submit a photo"), message: nil, buttons: [
                .default(Text("Take a Photo"), action: viewModel.takePhoto),
                .default(Text("Camera Roll"), action: viewModel.cameraRoll),
                .cancel()
            ])
        }.sheet(isPresented: $viewModel.isPickerPresented) {
            ImagePickerView(
                source: self.viewModel.pickerSourceType,
                image: self.$viewModel.selectedImage,
                isPresented: self.$viewModel.isPickerPresented)
        }
        .onAppear(perform: viewModel.appear)
        .onDisappear(perform: viewModel.disappear)
    }
    var smallCardSize: CGSize {
        
        let w = 110 * SCREEN_WIDTH / 414
        let h = 140 * w / 110
        return .init(width: w, height: h)
    }
    var bigCardSize: CGSize {
        
        let w = 190 * SCREEN_WIDTH / 414
        let h = 235 * w / 190
        return .init(width: w, height: h)
    }
    
    
    // MARK: - Premium
    
    var premiumButton: some View {
        HapticButton(action: {
            self.app.showPremium.toggle()
        }) {
            ZStack(alignment: .leading) {
                Text("Activate Premium")
                    //.kerning(-0.41)
                    .font(.regular(ISiPhone5 ? 20 : 22))
                    .padding(.all, ISiPhone5 ? 12 : 20)
                    .padding(.leading, 60)
                    .padding(.trailing, 50)
                    .background(Color.hOrange.cornerRadius(8))
                    .foregroundColor(Color.black)
                Image("unlock").resizable().frame(width: 30, height: 30, alignment: .leading).padding(.leading, 25)
            }
            .padding(.top, 10)
                .padding(.bottom, 10)
        }.centred
       
    }
    
    
    // MARK: - Activity
    
    var profileActivity: some View {
        
        VStack(alignment: .leading, spacing: 30) {
            Text("Profile Activity")
                .font(.regular(ISiPhone5 ? 24 : 28))
                .foregroundColor(Color(0x4F4F4F))
            VStack(spacing: 25) {
                if (self.showMatchesView) {
                    tableRow("Matches", $viewModel.basicsViewModel.matches.wrappedValue) {
                        self.showMatchesView.toggle()
                    }.background(
                        NavigationLink(
                            destination: MatchView(viewModel: MatchViewModel(), title: "Matches", match_type: "matches", blured: false).environmentObject(self.app).withoutBar(),
                            isActive: $showMatchesView,
                            label: EmptyView.init
                        )
                    )
                } else {
                    tableRow("Matches", $viewModel.basicsViewModel.matches.wrappedValue) {
                        self.showMatchesView.toggle()
                    }
                }
                
                if (self.showVisitedMeView) {
                    tableRow("Visited my Profile", $viewModel.basicsViewModel.visitedMe.wrappedValue) {
                        self.showVisitedMeView.toggle()
                    }.background(
                        NavigationLink(
                            destination: MatchView(viewModel: MatchViewModel(), title: "Visited Me", match_type: "visited_me", blured: !Common.premium() ).environmentObject(self.app).withoutBar(),
                           isActive: $showVisitedMeView,
                           label: EmptyView.init
                        )
                    )
                } else {
                    tableRow("Visited my Profile", $viewModel.basicsViewModel.visitedMe.wrappedValue) {
                        self.showVisitedMeView.toggle()
                    }
                }
                
                if (self.showLikesMeView) {
                    tableRow("Likes me", $viewModel.basicsViewModel.likesMe.wrappedValue) {
                        self.showLikesMeView.toggle()
                    }.background(
                        NavigationLink(
                            destination: MatchView(viewModel: MatchViewModel(), title: "Likes Me", match_type: "likes_me", blured: !Common.premium()).environmentObject(self.app).withoutBar(),
                           isActive: $showLikesMeView,
                           label: EmptyView.init
                        )
                    )
                } else {
                    tableRow("Likes me", $viewModel.basicsViewModel.likesMe.wrappedValue) {
                        self.showLikesMeView.toggle()
                    }
                }
                
                if (self.showMyLikeView) {
                    tableRow("My likes", $viewModel.basicsViewModel.myLikes.wrappedValue) {
                        self.showMyLikeView.toggle()
                    }.background(
                        NavigationLink(
                            destination: MatchView(viewModel: MatchViewModel(), title: "My Likes", match_type: "my_likes", blured: false).environmentObject(self.app).withoutBar(),
                           isActive: $showMyLikeView,
                           label: EmptyView.init
                        )
                    )
                } else {
                    tableRow("My likes", $viewModel.basicsViewModel.myLikes.wrappedValue) {
                        self.showMyLikeView.toggle()
                    }
                }
            }
        }.padding(.horizontal, 36)
            .padding(.top, 20)
    }
    
    
    // MARK: - Basics
    
    var profileBasics: some View {
        
        VStack(alignment: .leading, spacing: 25) {
            Text("Profile Basics")
                .font(.regular(ISiPhone5 ? 24 : 28))
                .foregroundColor(Color(0x4F4F4F))
            VStack(spacing: 25) {
                //tableRow("User Name", value: $viewModel.basicsViewModel.username)
                    tableRow("User Name", value: $viewModel.basicsViewModel.username) {
                        let name = self.$viewModel.basicsViewModel.username.wrappedValue
                        if Common.userNameValid(name: name) {
                            UserAPI.shared.update_name(name: name) { (error) in
                                
                            }
                        } else {
                            self.showAlert.toggle()
                            self.alertMessage = "User Name is invalid"
                        }
                    }
                    tableFixedRow("Premium User", value: $viewModel.premium, onCommit: {
                        if !Common.premium() {
                            self.showUpgrade.toggle()
                        }
                    })
                    //tableFixedRow("Premium User", value: $viewModel.basicsViewModel.isPremium)
                    tableFixedRow("Verified?", value: $viewModel.basicsViewModel.isVerified)
                    tablePickerRow("Age", selected: viewModel.basicsViewModel.age) { birthday in
                        let now = Date()
                        let calendar = Calendar.current
                        let ageComponents = calendar.dateComponents([.year], from: birthday, to: now)
                        let age = ageComponents.year!
                        
                        if (age == 0) {
                            return
                        }
                        
                        let strAge = "\(age)"
                        
                        if (strAge != self.$viewModel.basicsViewModel.age.wrappedValue) {
                            self.viewModel.updateAge(age: strAge)
                        }
                        self.$viewModel.basicsViewModel.age.wrappedValue = strAge
                    }
                    
                Group {
                    tablePickerRow("Gender", selected: viewModel.basicsViewModel.gender.title, titles: Gender.allTitles) {
                        var selectedGender = $0.lowercased()
                        if (selectedGender == "") {
                            selectedGender = "male"
                        }
                        if (selectedGender != self.$viewModel.basicsViewModel.gender.wrappedValue.rawValue)
                        {
                            self.viewModel.updateGender(gender: selectedGender)
                        }
                        self.$viewModel.basicsViewModel.gender.wrappedValue = Gender(rawValue: selectedGender)!
                    }
                    
                    tablePickerRow("Sexuality", selected: viewModel.basicsViewModel.sexuality.title, titles: Sex.allTitles) {
                        var selectedSex: String = $0.lowercased()
                        if (selectedSex == "") {
                            selectedSex = "gay"
                        } else {
                            selectedSex = Sex.typeForTitle(title: selectedSex)
                        }
                        if (selectedSex != self.$viewModel.basicsViewModel.sexuality.wrappedValue.rawValue)
                        {
                            self.viewModel.updateSex(sex: selectedSex)
                        }
                        self.$viewModel.basicsViewModel.sexuality.wrappedValue = Sex(rawValue: selectedSex)!
                    }
    
                    tablePickerRow("Looking for", selected: viewModel.basicsViewModel.looking.title, titles: Gender.allTitles) {
                        var selectedLooking = $0.lowercased()
                        if (selectedLooking == "") {
                            selectedLooking = "female"
                        }
                        if (selectedLooking != self.$viewModel.basicsViewModel.looking.wrappedValue.rawValue)
                        {
                            self.viewModel.updateLooking(gender: selectedLooking)
                        }
                        self.$viewModel.basicsViewModel.looking.wrappedValue = Gender(rawValue: selectedLooking)!
                    }
                    
                    tableFixedRow("Location", value: $viewModel.basicsViewModel.location, onCommit: {
                        self.partialSheetManager.showPartialSheet {
                            TextQuerySelectorView(provider: SelectLocationAPI(query: "") { newLocation in
                                
                                if let result = newLocation {
                                    AuthAPI.shared.get_geocode(address: result) { (lat, lng) in
                                        AuthAPI.shared.update_location(address: result, lat: lat!, lng: lng!) { (error) in
                                        
                                            self.$viewModel.basicsViewModel.location.wrappedValue = result
                                            var user = Common.userInfo()
                                            user.address = result
                                            user.latitude = lat
                                            user.longitude = lng
                                            Common.setUserInfo(user)
                                            Common.setAddressInfo(result)
                                            self.partialSheetManager.closePartialSheet()
                                        }
                                    }
                                } else {
                                    self.partialSheetManager.closePartialSheet()
                                }
                            })
                        }
                    })
                }
                                    
                tablePickerRow("Living", selected: viewModel.basicsViewModel.living.title, titles: Living.allTitles) {
                    var selectedLiving = $0.lowercased()
                    if (selectedLiving == "") {
                        selectedLiving = "alone"
                    } else {
                        selectedLiving = Living.typeForTitle(title: selectedLiving)
                    }
                    if (selectedLiving != self.$viewModel.basicsViewModel.living.wrappedValue.rawValue)
                    {
                       self.viewModel.updateLiving(living: selectedLiving)
                    }
                    self.$viewModel.basicsViewModel.living.wrappedValue = Living(rawValue: selectedLiving)!
                }
                
                tableRow("Bio", value: nil)
                
                if app.onProfileEditing {
                    
                    MultilineTextField("Bio", text: $viewModel.basicsViewModel.bio, height: $height) {
                        let bio = self.viewModel.basicsViewModel.bio
                        self.viewModel.updateBio(bio: bio)
                    }
                    .foregroundColor(.white)
                    
                } else {
                    Text(viewModel.basicsViewModel.bio).font(.regular(17)).foregroundColor(.white)
                }
                
                tablePickerRow("Language", selected: viewModel.basicsViewModel.language, titles: self.app.languageNames) {
                    var selectedLanguage = $0
                    if (selectedLanguage == "") {
                        selectedLanguage = "English"
                    }
                    if (selectedLanguage != self.$viewModel.basicsViewModel.language.wrappedValue)
                    {
                        var language_id = ""
                        for language in self.app.languageList {
                            if let name = language.name {
                                if name == selectedLanguage {
                                    language_id = language.id ?? ""
                                }
                            }
                        }
                        if (language_id.count > 0) {
                            UserAPI.shared.update_language(lang_id: language_id) { (error) in
                                if error == nil {
                                    
                                }
                            }
                            var user = Common.userInfo()
                            user.language = selectedLanguage
                            Common.setUserInfo(user)
                        }
                       
                    }
                    self.$viewModel.basicsViewModel.language.wrappedValue = selectedLanguage
                }
                
                //tableRow("Language", value: $viewModel.basicsViewModel.language)
            }
        }.padding(.horizontal, 36)
        .padding(.top, 20)
        .alert(isPresented: $showAlert) { () -> Alert in
            Alert(title: Text(""), message: Text(self.alertMessage).font(.regular(24)), dismissButton: .default(Text("OK"), action: {
                self.showAlert = false
            }))
        }
    }
    
    
    // MARK: - Notifications
    

    
    var notifications: some View {
        
        VStack(alignment: .leading, spacing: 25) {
            Text("Notifications")
                .font(.regular(28))
                .foregroundColor(Color(0x4F4F4F))
            VStack(spacing: 25) {
                tableRow("New Matches", $viewModel.basicsViewModel.noti_matches) { (toggled) in
                    self.viewModel.updateNotification(notification_type: "match_me", toogled: toggled)
                }
                tableRow("Message Likes", $viewModel.basicsViewModel.noti_likeMe) { (toggled) in
                    self.viewModel.updateNotification(notification_type: "fan", toogled: toggled)
                }
                tableRow("Messages", $viewModel.basicsViewModel.noti_messages) { (toggled) in
                    self.viewModel.updateNotification(notification_type: "message", toogled: toggled)
                }
                tableRow("People Nearby", $viewModel.basicsViewModel.noti_nearby) { (toggled) in
                    self.viewModel.updateNotification(notification_type: "near_me", toogled: toggled)
                }
            }
        }
        .padding(.leading, 36)
        .padding(.trailing, 25)
        .padding(.top, 20)
    }
    
    
    // MARK: - Legal
    
    var legal: some View {
        
        VStack(alignment: .leading, spacing: 25) {
            Text("Legal")
                .font(.regular(28))
                .foregroundColor(Color(0x4F4F4F))
            VStack(spacing: 25) {
                tableRow("Privacy & Terms") {
                    iOSApp.open(URL(string: "http://appsmallptint.com")!)
                }
//                tableRow("Privacy Policy") {
//                    iOSApp.open(URL(string: "https://google.com")!)
//                }
                
                HapticButton(action: {
                    self.viewModel.logout { (result, error) in
                        if (result) {
                            self.app.logedIn = false
                            self.app.loadingData = false
                            let isLoggedIn = UserDefault(.isLoggedIn, default: false)
                            isLoggedIn.wrappedValue = false
                        } else {
                            
                        }
                    }
                }) {
                    Text("Logout").font(.regular(17)).foregroundColor(.white)
                }
            }
        }
        .padding(.leading, 36)
        .padding(.trailing, 25)
        .padding(.top, 20)

    }
    
    
    // MARK: - Helper
    
    private func tableRow(_ title: String, value: Binding<String>?) -> some View {
        HStack {
            Text(title).font(.regular(17)).foregroundColor(.white)
            Spacer()
            if value != nil {
                if app.onProfileEditing {
                    TextField(title, text: value!).multilineTextAlignment(.trailing).font(.regular(17)).foregroundColor(.white)
                } else {
                    Text(value!.wrappedValue).font(.regular(17)).foregroundColor(.white)
                }
            }
        }
    }

    private func tableRow(_ title: String, value: Binding<String>?, onCommit: @escaping () -> Void) -> some View {
        HStack {
            Text(title).font(.regular(17)).foregroundColor(.white)
            Spacer()
            if value != nil {
                if app.onProfileEditing {
                    TextField(title, text: value!, onEditingChanged: { (edit) in
                    }) {
                        onCommit()
                    }.multilineTextAlignment(.trailing).font(.regular(17)).foregroundColor(.white)

                } else {
                    Text(value!.wrappedValue).font(.regular(17)).foregroundColor(.white)
                }
            }
        }
    }
    
    private func tableFixedRow(_ title: String, value: Binding<String>?, onCommit: @escaping () -> Void) -> some View {
        HStack {
            Text(title).font(.regular(17)).foregroundColor(.white)
            Spacer()
            if value != nil {
                Text(value!.wrappedValue).font(.regular(17)).foregroundColor(.white).onTapGesture {
                    onCommit()
                }
            }
        }
    }
    
    private func tableFixedRow(_ title: String, value: Binding<String>?) -> some View {
        HStack {
            Text(title).font(.regular(17)).foregroundColor(.white)
            Spacer()
            if value != nil {
                Text(value!.wrappedValue).font(.regular(17)).foregroundColor(.white)
            }
        }
    }
    
    private func tablePickerRow(_ title: String, selected: String, titles: [String], picked: @escaping (String) -> Void) -> some View {
        HStack {
            Text(title).font(.regular(17)).foregroundColor(.white)
            Spacer()
            if app.onProfileEditing {
                PickerTextField(title: selected, titles: titles, picked: picked)
                
            } else {
                Text(selected).font(.regular(17)).foregroundColor(.white)
            }
        }
    }
    
    private func tablePickerRow(_ title: String, selected: String, picked: @escaping (Date) -> Void) -> some View {
        HStack {
            Text(title).font(.regular(17)).foregroundColor(.white)
            Spacer()
            if app.onProfileEditing {
                DateTextField(title: selected, picked: picked)
                
            } else {
                Text(selected).font(.regular(17)).foregroundColor(.white)
            }
        }
    }
    
    private func tableRow(_ title: String, _ bool: Binding<Bool>, toggled: @escaping (Bool) -> Void) -> some View {
        HStack {
            Text(title).font(.regular(17)).foregroundColor(.white)
            Spacer()
            
            Toggle("", isOn: bool)
                .toggleStyle(HToggleStyle(onColor: Color(0x7ED321), offColor: Color(0xEB5757)))
        }
    }
    
    private func tableRow(_ title: String, _ action: @escaping () -> Void) -> some View {
        HapticButton(action: action) {
            HStack {
                Text(title).font(.regular(17)).foregroundColor(.white)
                Spacer()
                
                Image("arrow_next_icon")
                    .aspectRatio(.fit)
                    .foregroundColor(.white)
                    .frame(width: 15, height: 15)
            }
        }
    }
    
    private func tableRow(_ title: String, _ value: String, _ action: @escaping () -> Void) -> some View {
        HapticButton(action: action) {
            HStack {
                Text(title).font(.regular(17)).foregroundColor(.white)
                Spacer()
                Text(value).font(.regular(17)).foregroundColor(.white).padding(.trailing, 5)

                Image("arrow_next_icon")
                    .aspectRatio(.fit)
                    .foregroundColor(.white)
                    .frame(width: 15, height: 15)
            }.contentShape(Rectangle())

        }
    }
}

struct MyProfileView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            NavigationView {
                MyProfileView(viewModel: MyProfileViewModel()).withoutBar().environmentObject(App())
            }.previewDevice(.init(rawValue: "iPhone SE 1"))
            NavigationView {
                MyProfileView(viewModel: MyProfileViewModel()).withoutBar().environmentObject(App())
            }.previewDevice(.init(rawValue: "iPhone 8"))
            NavigationView {
                MyProfileView(viewModel: MyProfileViewModel()).withoutBar().environmentObject(App())
            }.previewDevice(.init(rawValue: "iPhone XS Max"))
        }
    }
}
