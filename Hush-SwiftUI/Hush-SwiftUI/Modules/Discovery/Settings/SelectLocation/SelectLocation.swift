//
//  SelectLocation.swift
//  Hush-SwiftUI
//
//  Created by Serge Vysotsky on 10.05.2020.
//  Copyright © 2020 AppServices. All rights reserved.
//

import SwiftUI
import PartialSheet

struct SelectLocation<ViewModel: SelectLocationViewModeled>: View {
    @ObservedObject var viewModel: ViewModel
    @EnvironmentObject private var partialSheetManager: PartialSheetManager
    @EnvironmentObject private var app: App
    
    var body: some View {
        VStack {
            HStack {
                Text("Filter").font(.bold(24))
                Spacer()
            }.padding(.horizontal)
            .padding(.bottom)
            
            HStack {
                FirstResponderTextField(
                    title: "Type your city",
                    text: $viewModel.query,
                    isFirstResponder: $app.isFirstResponder,
                    textColor: UIColor(0x8E8786),
                    font: .light(17)
                ).fixedSize(horizontal: false, vertical: true)
                .padding(.horizontal, 5)
                .onAppear { self.app.isFirstResponder = true }
                
                Button(action: {}) {
                    Text("Cancel")
                        .font(.light())
                    .offset(x: 0, y: -10)
                }
            }.padding(.horizontal)
            .foregroundColor(Color(0x8E8786))
            
            Rectangle().fill(Color(0xC6C6C8))
                .frame(height: 0.5)
                .padding(.horizontal, 20)
            
            HStack {
                Text(viewModel.searchResult)
                    .foregroundColor(Color(0x8E8786))
                    .font(.light())
                    .onTapGesture {
                        self.viewModel.settingsViewModel.location = self.viewModel.searchResult
                        self.app.isFirstResponder = false
                        self.partialSheetManager.closePartialSheet()
                        self.viewModel.settingsViewModel.selectLocationCompletion?()
                }
                Spacer()
            }.padding(.horizontal, 20)
        }
    }
}

struct SelectLocation_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            RootTabBarView(viewModel: RootTabBarViewModel())
        }.environmentObject(App())
        .environmentObject(PartialSheetManager())
    }
}
