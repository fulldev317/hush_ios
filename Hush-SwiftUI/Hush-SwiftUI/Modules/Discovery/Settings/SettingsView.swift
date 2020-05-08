//
//  SettingsView.swift
//  Hush-SwiftUI
//
//  Created Dima Virych on 02.04.2020.
//  Copyright © 2020 AppServices. All rights reserved.
//

import SwiftUI

struct SettingsView<ViewModel: SettingsViewModeled>: View {
    
    // MARK: - Properties
    
    @ObservedObject private var viewModel: ViewModel
    @State private var firstSliderFalue = 0.0
    @State private var secondSliderFalue = 0.0
    @State private var isToggle = true
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
    }
    
    
    // MARK: - Lifecycle
    
    var body: some View {
        VStack {
            HStack {
                Text("Filter").font(.bold(24)).foregroundColor(Color(0x010101))
                Spacer()
            }.padding(.bottom, 40)
            VStack {
                HStack {
                    Text("Location").font(.light()).foregroundColor(Color(0x010101))
                    Spacer()
                    Text(viewModel.location).font(.light()).foregroundColor(Color(0x010101))
                    Spacer()
                    Text("Edit").font(.light()).foregroundColor(Color(0x8E8786))
                }
                Rectangle().foregroundColor(Color(0xC6C6C8)).frame(height: 0.5)
            }
            VStack {
                HStack {
                    Text("Gender").font(.light()).foregroundColor(Color(0x010101))
                    Spacer()
                    Text(viewModel.gender).font(.light()).foregroundColor(Color(0x010101))
                    Spacer()
                    Text("Edit").font(.light()).foregroundColor(Color(0x8E8786))
                }
                Rectangle().foregroundColor(Color(0xC6C6C8)).frame(height: 0.5)
            }
            VStack {
                HStack {
                    Text("Maximum distance").font(.light()).foregroundColor(Color(0x010101))
                    Spacer()
                    Text("25 Yards").font(.light()).foregroundColor(Color(0x010101))
                }
                Rectangle().foregroundColor(Color(0xC6C6C8)).frame(height: 0.5)
            }
            VStack {
                SingleSlider(value: $firstSliderFalue)
                Rectangle().foregroundColor(Color(0xC6C6C8)).frame(height: 0.5)
            }.animation(nil)
            VStack {
                HStack {
                    Text("Age range").font(.light()).foregroundColor(Color(0x010101))
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
                        DoubleSlider(lower: $ageSliderLower, upper: $ageSliderUpper)
                        Text("99").opacity(0)
                    }
                }.font(.light(18)).animation(nil)
                Rectangle().foregroundColor(Color(0xC6C6C8)).frame(height: 0.5)
            }
            VStack {
                HStack {
                    Text("Online users").font(.light()).foregroundColor(Color(0x010101))
                    Spacer()
                    Toggle("", isOn: $isToggle)
                }
                Rectangle().foregroundColor(Color(0xC6C6C8)).frame(height: 0.5)
            }.padding(.top, 20)
            Spacer()
        }.padding(.horizontal, 20)
        .frame(height: 500)
        .withoutBar()
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            NavigationView {
                SettingsView(viewModel: SettingsViewModel())
            }.previewDevice(.init(rawValue: "iPhone SE"))
            NavigationView {
                SettingsView(viewModel: SettingsViewModel())
                }.previewDevice(.init(rawValue: "iPhone 8"))
            NavigationView {
                SettingsView(viewModel: SettingsViewModel())
            }.previewDevice(.init(rawValue: "iPhone XS Max"))
        }
    }
}
