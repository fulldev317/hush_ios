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
    @State var showAlert = false
    @State var alertMessage = ""
    
    // MARK: - Lifecycle
    
    var body: some View {
        ZStack {
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
                    ImagesCarusel(uiElements: viewModel.getElements()).padding(.bottom, 20)

                    VStack {
                        ZStack {
                            Rectangle().foregroundColor(.hOrange).frame(height: 50)
                            .onTapGesture {
                                if (self.viewModel.oneWeek) {
                                    self.viewModel.upgradeOneWeek { (alert, message) in
                                        if (alert) {
                                            if message == "success" {
                                                self.mode.wrappedValue.dismiss()
                                            } else {
                                                self.showAlert = true
                                                self.alertMessage = message
                                            }
                                        }
                                    }
                                }
                            }
                            HStack {
                                HStack {
                                    Text("1 Week ").font(.bold(ISiPhone5 ? 16 : 18)) + Text("Trial").font(.light(ISiPhone5 ? 16 : 18))
                                }.padding(.leading, 0)
                                Spacer()
                                Text("$14,99").font(.regular(ISiPhone5 ? 14 : 18))
                                    .padding(.trailing, 80)
                            }.padding(.leading, 15)
                        }.opacity(self.viewModel.oneWeek ? 1.0 : 0.6)
                        
                        ZStack {
                            Rectangle().foregroundColor(.hOrange).frame(height: 50)
                            .onTapGesture {
                                if (self.viewModel.oneMonth) {
                                    self.viewModel.upgradeOneMonth { (alert, message) in
                                        if (alert) {
                                            if message == "success" {
                                                self.mode.wrappedValue.dismiss()
                                            } else {
                                                self.showAlert = true
                                                self.alertMessage = message
                                            }
                                        }
                                    }
                                }
                            }
                            HStack {
                                Text("1 Month ").font(.bold(ISiPhone5 ? 16 : 18)) + Text("Premium").font(.light(ISiPhone5 ? 16 : 18))
                                Spacer()
                                Text("$29,49").font(.light(ISiPhone5 ? 14 : 18))
                                    .padding(.trailing, 80)
                            }.padding(.leading, 15)
                        }.opacity(self.viewModel.oneMonth ? 1.0 : 0.6)
                        ZStack {
                            Rectangle().foregroundColor(.hOrange).frame(height: 50)
                                .onTapGesture {
                                    if (self.viewModel.threeMonth) {
                                        self.viewModel.upgradeThreeMonth { (alert, message) in
                                            if (alert) {
                                                if message == "success" {
                                                    self.mode.wrappedValue.dismiss()
                                                } else {
                                                    self.showAlert = true
                                                    self.alertMessage = message
                                                }
                                            }
                                        }
                                    }
                            }
                            HStack {
                                Spacer()
                                Rectangle().foregroundColor(Color(0x27AE60)).frame(width: ISiPhone5 ? 75 : 80, height: 50)
                                    .overlay(
                                        Text("Best\nValue")
                                            .multilineTextAlignment(.center)
                                            .font(.bold(16))
                                            .foregroundColor(.white)
                                )
                            }
                            HStack {
                                Text("3 Month ").font(.bold(ISiPhone5 ? 16 : 18)) + Text("Value").font(.light(ISiPhone5 ? 16 : 18))
                                Spacer()
                                Text("$47,99 ").font(.light(ISiPhone5 ? 14 : 18))
                                    .padding(.trailing, 80)
                            }.padding(.leading, 15)
                        }.opacity(self.viewModel.threeMonth ? 1.0 : 0.6)
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
            .alert(isPresented: $showAlert) { () -> Alert in
                Alert(title: Text(""), message: Text(self.alertMessage).font(.regular(24)), dismissButton: .default(Text("OK"), action: {
                    self.showAlert = false
                }))
            }
            
            HushIndicator(showing: self.viewModel.showingIndicator)

        }
    }
}

struct UpgradeView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            NavigationView {
                UpgradeView(viewModel: UpgradeViewModel(isMatched: true)).withoutBar()
            }.previewDevice(.init(rawValue: "iPhone SE 1"))
            NavigationView {
                UpgradeView(viewModel: UpgradeViewModel(isMatched: true)).withoutBar()
            }.previewDevice(.init(rawValue: "iPhone 8"))
            NavigationView {
                UpgradeView(viewModel: UpgradeViewModel(isMatched: true))
            }.previewDevice(.init(rawValue: "iPhone XS Max")).withoutBar()
        }
    }
}
