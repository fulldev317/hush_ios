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
    
    @ObservedObject var viewModel: ViewModel
    @State var firstSliderFalue = 0.0
    @State var secondSliderFalue = 0.0
    @State var isToggle = false
    
    
    // MARK: - Lifecycle
    
    var body: some View {
        VStack {
            HStack {
                Text(viewModel.message).font(.bold(24)).foregroundColor(Color(0x010101))
                Spacer()
            }.padding(.bottom, 40)
            VStack {
                HStack {
                    Text(viewModel.message).font(.light()).foregroundColor(Color(0x010101))
                    Spacer()
                    Text(viewModel.message).font(.light()).foregroundColor(Color(0x010101))
                    Spacer()
                    Text(viewModel.message).font(.light()).foregroundColor(Color(0x8E8786))
                }
                Rectangle().foregroundColor(Color(0xC6C6C8)).frame(height: 0.5)
            }
            VStack {
                HStack {
                    Text(viewModel.message).font(.light()).foregroundColor(Color(0x010101))
                    Spacer()
                    Text(viewModel.message).font(.light()).foregroundColor(Color(0x010101))
                    Spacer()
                    Text(viewModel.message).font(.light()).foregroundColor(Color(0x8E8786))
                }
                Rectangle().foregroundColor(Color(0xC6C6C8)).frame(height: 0.5)
            }
            VStack {
                HStack {
                    Text(viewModel.message).font(.light()).foregroundColor(Color(0x010101))
                    Spacer()
                    Text(viewModel.message).font(.light()).foregroundColor(Color(0x010101))
                }
                Rectangle().foregroundColor(Color(0xC6C6C8)).frame(height: 0.5)
            }
            VStack {
                Slider(value: $firstSliderFalue, onEditingChanged: { _ in
                    self.viewModel.dragFlag = false
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        self.viewModel.dragFlag = true
                    }
                })
                Rectangle().foregroundColor(Color(0xC6C6C8)).frame(height: 0.5)
            }
            VStack {
                HStack {
                    Text(viewModel.message).font(.light()).foregroundColor(Color(0x010101))
                    Spacer()
                    Text(viewModel.message).font(.light()).foregroundColor(Color(0x010101))
                }
                Rectangle().foregroundColor(Color(0xC6C6C8)).frame(height: 0.5)
            }
            VStack {
                Slider(value: $secondSliderFalue, onEditingChanged: { _ in
                    self.viewModel.dragFlag = false
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        self.viewModel.dragFlag = true
                    }
                })
                Rectangle().foregroundColor(Color(0xC6C6C8)).frame(height: 0.5)
            }
            VStack {
                HStack {
                    Text(viewModel.message).font(.light()).foregroundColor(Color(0x010101))
                    Spacer()
                    Toggle("", isOn: $isToggle)
                }
                Rectangle().foregroundColor(Color(0xC6C6C8)).frame(height: 0.5)
            }.padding(.top, 20)
            Spacer()
        }.padding(.horizontal, 20).withoutBar()
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
