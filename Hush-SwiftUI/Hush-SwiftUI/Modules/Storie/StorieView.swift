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
    @State var hide = false
    
    
    // MARK: - Lifecycle
    
    var body: some View {
        
        VStack {
            HStack {
                HapticButton(action: {
                    self.mode.wrappedValue.dismiss()
                }, label: {
                    closeBlock().opacity(hide ? 0 : 1)
                })
                Spacer()
                titleBlock().opacity(hide ? 0 : 1)
            }
            Spacer()
        }
        .background(
            Image(uiImage: viewModel.placeholder)
                .aspectRatio()
                .edgesIgnoringSafeArea(.all)
                .onTapGesture {
                    withAnimation {
                        self.hide.toggle()
                    }
            }
        ).withoutBar()
            .overlay(storiesCounter().opacity(hide ? 0 : 1))
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
    
    private func storiesCounter() -> some View {
        
        VStack {
            HStack(alignment: .top) {
                Spacer()
                VStack {
                    ForEach(0 ..< viewModel.numberOfStories) { _ in
                        Rectangle()
                            .foregroundColor(.hOrange)
                            .frame(width: 5)
                            .frame(minHeight: 5, maxHeight: 84)
                    }
                }.frame(width: 5, height: 350)
            }
            Spacer()
        }.padding(.top, 100).padding(.trailing, 20)
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
