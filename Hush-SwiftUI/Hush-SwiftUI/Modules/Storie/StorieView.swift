//
//  StorieView.swift
//  Hush-SwiftUI
//
//  Created Dima Virych on 03.04.2020.
//  Copyright © 2020 AppServices. All rights reserved.
//

import SwiftUI

struct StorieView<ViewModel: StorieViewModeled>: View {
    
    // MARK: - Properties
    
    @Environment(\.presentationMode) var mode
    @ObservedObject var viewModel: ViewModel
    
    
    // MARK: - Lifecycle
    
    var body: some View {
        
        VStack {
            HStack {
                HapticButton(action: {
                    self.mode.wrappedValue.dismiss()
                }, label: {
                    closeBlock()
                })
                Spacer()
                titleBlock()
            }
            Spacer()
        }
    .background(
        Image(uiImage: viewModel.placeholder)
            .aspectRatio()
            .edgesIgnoringSafeArea(.all)
        ).withoutBar()
    }
    
    private func closeBlock() -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .frame(width: 53, height: 64)
                .opacity(0.2)
            Image("close_icon")
                .aspectRatio(.fit)
                .frame(width: 25, height: 25)
        }
        .padding(.leading, 20)
        .padding(.top, 25)
    }
    
    private func titleBlock() -> some View {
        
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .opacity(0.2)
                .frame(height: 64)
            HStack {
                VStack(alignment: .leading) {
                    Text("Long username").lineLimit(1).minimumScaleFactor(0.5).font(.bold(24)).foregroundColor(.white)
                    Text("21 minutes ago").lineLimit(1).minimumScaleFactor(0.5).font(.thin()).foregroundColor(.white)
                }
                Spacer()
                Image("messages_icon")
                .aspectRatio(.fit)
                .frame(width: 35, height: 35)
                Image("heart_icon")
                .aspectRatio(.fit)
                .frame(width: 35, height: 35)
            }.padding(.horizontal, 10)
        }
        .padding(.trailing, 20)
        .padding(.top, 25)
    }
}

struct StorieView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            NavigationView {
                StorieView(viewModel: StorieViewModel())
            }.previewDevice(.init(rawValue: "iPhone SE"))
            NavigationView {
                StorieView(viewModel: StorieViewModel())
            }.previewDevice(.init(rawValue: "iPhone 8"))
            NavigationView {
                StorieView(viewModel: StorieViewModel())
            }.previewDevice(.init(rawValue: "iPhone XS Max"))
        }
    }
}
