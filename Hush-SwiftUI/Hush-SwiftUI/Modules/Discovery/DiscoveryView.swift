//
//  DiscoveryView.swift
//  Hush-SwiftUI
//
//  Created Dima Virych on 02.04.2020.
//  Copyright © 2020 AppServices. All rights reserved.
//

import SwiftUI
import QGrid
import PartialSheet

struct DiscoveryView<ViewModel: DiscoveryViewModeled>: View {
    
    // MARK: - Properties
    
    @ObservedObject var viewModel: ViewModel
    @State var showSettings = false
    
    var top: CGFloat {
        if let top = UIApplication.shared.windows.first?.rootViewController?.view.safeAreaInsets.top {
            return top
        }
        return 0
    }
    
    // MARK: - Lifecycle
    
    var body: some View {
        VStack {
            header().padding(.top, top)
            QGrid(viewModel.messages, columns: 2) { element in
                
                UserCardView(image: UIImage(named: "image3")!, bottomView: self.bottomView(element), size: .init(width: (SCREEN_WIDTH / 2), height: 280 * (SCREEN_WIDTH / 2) / 237))
                    .background(Rectangle().shadow(color: Color.black.opacity(0.5), radius: 8, x: 0, y: -4))
                    .rotate(self.viewModel.index(element).isMultiple(of: 3) ? 0 : -5)
                
            }
        }.partialSheet(presented: $showSettings, enabledDrag: viewModel.settingsViewModel.dragFlag, viewForGesture: Rectangle().frame(height: 44).foregroundColor(.white), view: {
                SettingsView(viewModel: self.viewModel.settingsViewModel).frame(height: 400)
            }).withoutBar().background(Color.black.edgesIgnoringSafeArea(.all))
    }
    
    #warning("Please update viewModel")
    func bottomView(_ viewModel: String) -> some View {
        HStack {
            (Text("Emily") + Text(", ") + Text("\(29)")).font(.regular(14)).foregroundColor(Color(0x8E8786))
            if true {
                Spacer()
                Image("red_heart").resizable().aspectRatio(contentMode: .fit)
                .frame(width: 25, height: 25)
            } else {
                Spacer()
            }
        }.padding(15)
    }
    
    private func header() -> some View {
        HStack {
            VStack(alignment: .leading) {
                Text("Discovery").foregroundColor(.hOrange).font(.ultraLight(48))
                Text("Location").foregroundColor(.white).font(.thin())
            }
            Spacer()
            HapticButton(action: {
                self.showSettings = true
            }) {
                Image("settings_icon").resizable().frame(width: 25, height: 25).padding(30)
            }
        }.padding(.leading, 30)
    }
}

struct DiscoveryView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            NavigationView {
                DiscoveryView(viewModel: DiscoveryViewModel())
            }.previewDevice(.init(rawValue: "iPhone SE"))
            NavigationView {
                DiscoveryView(viewModel: DiscoveryViewModel())
            }.previewDevice(.init(rawValue: "iPhone 8"))
            NavigationView {
                DiscoveryView(viewModel: DiscoveryViewModel())
            }.previewDevice(.init(rawValue: "iPhone XS Max"))
        }
    }
}
