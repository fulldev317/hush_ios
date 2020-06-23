//
//  TextQuerySelectorView.swift
//  Hush-SwiftUI
//
//  Created by Serge Vysotsky on 12.05.2020.
//  Copyright © 2020 AppServices. All rights reserved.
//

import SwiftUI
import PartialSheet

struct TextQuerySelectorView<Provider: TextQueryAPIProvider>: View {
    @ObservedObject var provider: Provider
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
                    title: provider.inputTitle,
                    text: $provider.query,
                    isFirstResponder: $app.isFirstResponder,
                    textColor: UIColor(0x8E8786),
                    font: .light(17)
                ).fixedSize(horizontal: false, vertical: true)
                .padding(.horizontal, 5)
                .onAppear { self.app.isFirstResponder = true }
                
                Button(action: close) {
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
                Text(provider.searchResult)
                    .foregroundColor(Color(0x8E8786))
                    .font(.light())
                    .onTapGesture(perform: select)
                Spacer()
            }.padding(.horizontal, 20)
        }.animation(nil)
    }
    
    private func select() {
        closeSheet()
        provider.select(provider.searchResult)
    }
    
    private func close() {
        closeSheet()
        provider.close()
    }
    
    private func closeSheet() {
        app.isFirstResponder = false
    }
}
