//
//  UpgradeView.swift
//  Hush-SwiftUI
//
//  Created Dima Virych on 07.04.2020.
//  Copyright © 2020 AppServices. All rights reserved.
//

import SwiftUI

struct UpgradeView<ViewModel: UpgradeViewModeled>: View {
    
    // MARK: - Properties
    
    @ObservedObject var viewModel: ViewModel
    @Environment(\.presentationMode) var mode
    
    
    // MARK: - Lifecycle
    
    var body: some View {
        ScrollView(.vertical) {
            VStack {
                HStack {
                    Spacer()
                    HapticButton(action: {
                        self.mode.wrappedValue.dismiss()
                    }) {
                        Image("close_icon").aspectRatio(.fit).frame(width: 25, height: 25).padding([.trailing, .top], 16)
                    }
                }
                Text("Go Premium")
                    .font(.ultraLight(48))
                    .foregroundColor(.hOrange)
                ImagesCarusel(uiElements: viewModel.uiElements).padding(.bottom, 20)

                VStack {
                    ZStack {
                        Rectangle().foregroundColor(.hOrange).frame(height: 50)
                        HStack {
                            Text("1 Week ").font(.bold()) + Text("Trial").font(.light())
                            Spacer()
                            Text("$14,99")
                                .padding(.trailing, 90)
                        }.padding(.leading, 15)
                    }.opacity(0.6)
                    ZStack {
                        Rectangle().foregroundColor(.hOrange).frame(height: 50)
                        HStack {
                            Text("3 Month ").font(.bold()) + Text("Premium").font(.light())
                            Spacer()
                            Text("$47,99")
                                .padding(.trailing, 90)
                        }.padding(.leading, 15)
                    }.opacity(0.6)
                    ZStack {
                        Rectangle().foregroundColor(.hOrange).frame(height: 50)
                        HStack {
                            Spacer()
                            Rectangle().foregroundColor(Color(0x27AE60)).frame(width: 80, height: 50)
                                .overlay(
                                    Text("Best\nValue")
                                        .multilineTextAlignment(.center)
                                        .font(.bold(16))
                                        .foregroundColor(.white)
                            )
                        }
                        HStack {
                            Text("12 Month ").font(.bold()) + Text("Value").font(.light())
                            Spacer()
                            Text("$78,99")
                                .padding(.trailing, 90)
                        }.padding(.leading, 15)
                    }
                    ZStack {
                        Rectangle().foregroundColor(Color(0x27AE60)).frame(height: 50)
                        Text("Continue")
                            .multilineTextAlignment(.center)
                            .font(.bold())
                            .foregroundColor(.white)
                    }.padding(.top, 10).padding(.bottom, 20)
                    Text("Payment will be charged to your iTunes Account at confirmation of purchase. Subscriptions automatically renewunless auto-renew is turned off at least 24 hours before the end of the current period. Account will be charged for renewal within 24 hours prior to the end of the current period. Account will be charged for renewal with 24 hours prior to the end of the current periodand identify the cost of renewal. Subscriptions may be managed by the user and auto renewal may be turned off by going to the users Account Settings after purchase. Any unused portion of a free trial period if offered will be forfeit when the user purchases a subscription to that publication where applicable.")
                        .kerning(-0.36)
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        .font(.regular(10))
                }.padding(.horizontal, 20)
            }
            
            Rectangle()
                .frame(width: 150, height: 0.5)
                .foregroundColor(Color(0xbdbdbd)).padding(.vertical)
            
            HapticButton(action: {}) {
                Text("Restore Purchase")
                    .font(.regular(10))
                    .foregroundColor(.white)
            }
            .padding(.bottom, 30)
        }.background(Color.hBlack.edgesIgnoringSafeArea(.all))
    }
}

struct UpgradeView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            NavigationView {
                UpgradeView(viewModel: UpgradeViewModel()).withoutBar()
            }.previewDevice(.init(rawValue: "iPhone SE"))
            NavigationView {
                UpgradeView(viewModel: UpgradeViewModel()).withoutBar()
            }.previewDevice(.init(rawValue: "iPhone 8"))
            NavigationView {
                UpgradeView(viewModel: UpgradeViewModel())
            }.previewDevice(.init(rawValue: "iPhone XS Max")).withoutBar()
        }
    }
}