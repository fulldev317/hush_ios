//
//  DiscoveriesSettingsView.swift
//  Hush-SwiftUI
//
//  Created Dima Virych on 02.04.2020.
//  Copyright © 2020 AppServices. All rights reserved.
//

import SwiftUI
import PartialSheet

struct DiscoveriesSettingsView<ViewModel: DiscoveriesSettingsViewModeled>: View {
    
    // MARK: - Properties
    
    @ObservedObject private var viewModel: ViewModel
    @EnvironmentObject private var app: App
    @EnvironmentObject private var partialSheetManager: PartialSheetManager
    @Environment(\.colorScheme) var colorScheme
    @State private var firstSliderValue = 0.0
    @State private var selectedSliderValue = 0.0

    @State private var secondSliderFalue = 0.0
    @State private var isToggle = true
    @State var showLocation: Bool = false
    @State private var ageSliderLower = 0.0
    @State private var ageSliderUpper = 1.0
    
    private var lowerAge: String {
        String(Int(18 + (99 - 18) * ageSliderLower))
    }
    
    private var upperAge: String {
        String(Int(18 + (99 - 18) * ageSliderUpper))
    }
    
    init(viewModel: ViewModel) {
        self.viewModel = viewModel
        UIView.appearance().subviews.forEach {
            $0.isExclusiveTouch = true
        }
        self.viewModel.location = Common.addessInfo()
        self.$firstSliderValue.wrappedValue = Common.maxRangeInfo()
        
    }
    
    
    // MARK: - Lifecycle
    
    var body: some View {

        VStack {
            HStack {
                Text("Filter").font(.bold(24))
                Spacer()
                Button(action: {
                    self.app.isShowingSetting = false
                    self.partialSheetManager.closePartialSheet()
                }) {
                    Text("Done").font(.bold(16))
                }
            }.padding(.bottom, 40)
            VStack {
                HStack {
                    Text("Location").font(.light())
                    
                    Spacer()
                    Text(self.viewModel.location)
                    //Text(viewModel.location.components(separatedBy: .punctuationCharacters).first ?? String()).font(.light())
                    Spacer()
                    Button(action: {
                        self.partialSheetManager.showPartialSheet({
                            self.app.isFirstResponder = false
                        }, content: {
                            TextQuerySelectorView(provider: SelectLocationAPI(query: "") { newLocation in
                                if let result = newLocation {
                                    
                                    AuthAPI.shared.get_geocode(address: result) { (lat, lng) in
                                        AuthAPI.shared.update_location(address: result, lat: lat!, lng: lng!) { (error) in
                                        
                                            self.viewModel.location = result

                                            var user = Common.userInfo()
                                            user.address = result
                                            user.latitude = lat
                                            user.longitude = lng
                                            Common.setUserInfo(user)
                                            
                                            Common.setAdderesInfo(result)
                                        }
                                    }
                                }
                                
                                self.partialSheetManager.showPartialSheet {
                                    DiscoveriesSettingsView(viewModel: self.viewModel)
                                }
                            })
                        })
                    }) {
                        Text("Edit").font(.light()).foregroundColor(Color(0x8E8786))
                    }
                }
                Rectangle().foregroundColor(Color(0xC6C6C8)).frame(height: 0.5)
            }
            VStack {
                HStack {
                    Text("Gender").font(.light())
                    Spacer()
                    Text(self.viewModel.gender.title).font(.light())
                    Spacer()
                    Button(action: {
                        self.app.selectingGender.toggle()
                        
                    }) {
                        Text("Edit").font(.light()).foregroundColor(Color(0x8E8786))
                    }
                }
                Rectangle().foregroundColor(Color(0xC6C6C8)).frame(height: 0.5)
            }
            VStack {
                HStack {
                    Text("Maximum distance").font(.light())
                    Spacer()
                    Text(maxDistance)
                        .font(.light())
                }.animation(nil)
                Rectangle().foregroundColor(Color(0xC6C6C8)).frame(height: 0.5)
            }
            VStack {
                SingleSlider(value: $firstSliderValue, selectedValue: $viewModel.selectedDistance)
                Rectangle().foregroundColor(Color(0xC6C6C8)).frame(height: 0.5)
            }.animation(nil)
            VStack {
                HStack {
                    Text("Age range").font(.light())
                    Spacer()
                }
                Rectangle().foregroundColor(Color(0xC6C6C8)).frame(height: 0.5)
            }
            VStack {
                ZStack {
                    HStack {
                        Text(lowerAge)
                        Spacer()
                        Text(upperAge)
                    }
                    
                    HStack {
                        Text("99").opacity(0)
                        DoubleSlider(lower: $ageSliderLower, lowerSelected: $viewModel.ageSelLower, upper: $ageSliderUpper, upperSelected: $viewModel.ageSelUpper)
                        Text("99").opacity(0)
                    }
                }.font(.light(18)).animation(nil)
                Rectangle().foregroundColor(Color(0xC6C6C8)).frame(height: 0.5)
            }
            VStack {
                HStack {
                    Text("Online users").font(.light())
                    Spacer()
                    Toggle("", isOn: $isToggle)
                }
                Rectangle().foregroundColor(Color(0xC6C6C8)).frame(height: 0.5)
            }.padding(.top, 20)
            Spacer()
        }.padding(.horizontal, 20)
//        .frame(height: 500)
        .fixedSize(horizontal: false, vertical: true)
        .withoutBar()
    }
    
    var maxDistance: String {
        let miles = 10 + firstSliderValue * 80
        let kilometers = miles * 1.6
        
        return String(format: "%.f Miles (%.fkm)", miles, kilometers)

    }
    
}

//struct SettingsView_Previews: PreviewProvider {
//    static var previews: some View {
//        Group {
//            NavigationView {
//                DiscoveriesSettingsView(viewModel: DiscoveriesSettingsViewModel())
//            }.previewDevice(.init(rawValue: "iPhone SE"))
//            NavigationView {
//                SettingsView(viewModel: SettingsViewModel())
//                }.previewDevice(.init(rawValue: "iPhone 8"))
//            NavigationView {
//                SettingsView(viewModel: SettingsViewModel())
//            }.previewDevice(.init(rawValue: "iPhone XS Max"))
//        }
//    }
//}

struct DiscoveriesSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        Group {

            DiscoveriesSettingsView(viewModel: DiscoveriesSettingsViewModel()).environment(\.colorScheme, .light)
                   
        
            DiscoveriesSettingsView(viewModel: DiscoveriesSettingsViewModel()).environment(\.colorScheme, .dark)
        }
    }
}
