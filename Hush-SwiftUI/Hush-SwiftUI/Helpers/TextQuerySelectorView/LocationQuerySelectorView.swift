//
//  LocationQuerySelectorView.swift
//  Hush-SwiftUI
//
//  Created by Serge Vysotsky on 12.05.2020.
//  Copyright © 2020 AppServices. All rights reserved.
//

import SwiftUI
import PartialSheet

struct LocationQuerySelectorView<Provider: TextQueryAPIProvider>: View {
    @ObservedObject var provider: Provider
    @EnvironmentObject private var app: App
    @State var isLocationResponder: Bool = true
    
    var body: some View {
        ZStack {
           
            VStack {
                RoundedRectangle(cornerRadius: 6)
                .stroke(Color.white, lineWidth: 2)
                .foregroundColor(.clear)
                .background(Color.clear)
                .frame(height: 48).cornerRadius(6)
                Spacer()
            }
            
            VStack {
                HStack {
                    LocationTextField(
                        title: provider.inputTitle,
                        text: $provider.query,
                        isLocationResponder: $isLocationResponder,
                        textColor: UIColor.white,
                        font: .regular(17)
                    ).fixedSize(horizontal: false, vertical: true)
                        .padding(.horizontal).padding(.vertical, 5)
                    .onAppear {}
                    
                }.padding(.horizontal, 5)
                .foregroundColor(Color(0x8E8786))
                    .padding(.top, 10)

                if isLocationResponder && provider.searchResult.count > 0 {
                    HStack {
                        Text(provider.searchResult)
                            .foregroundColor(Color(0x8E8786))
                            .font(.regular())
                            .onTapGesture(perform: select)
                            .padding(.vertical, 5)
                            .padding(.top, 5)
                        Spacer()
                    }.padding(.horizontal, 20)
                        .background(Color.yellow)
                } else {
                    HStack {
                        Text("")
                            .foregroundColor(Color(0x8E8786))
                            .font(.regular())
                            .padding(.vertical, 5)
                            .padding(.top, 5)
                        Spacer()
                    }.padding(.horizontal, 20)
                }
            }
            
        }.animation(nil)
        
    }
    
    private func select() {
        provider.select(provider.searchResult)
        isLocationResponder = false
    }
    
    private func close() {
        //closeSheet()
        //provider.close()
    }
    
    private func closeSheet() {
        //app.isFirstResponder = false
    }
}

