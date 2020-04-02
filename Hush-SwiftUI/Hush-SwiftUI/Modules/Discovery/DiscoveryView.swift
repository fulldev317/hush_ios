//
//  DiscoveryView.swift
//  Hush-SwiftUI
//
//  Created Dima Virych on 02.04.2020.
//  Copyright © 2020 AppServices. All rights reserved.
//

import SwiftUI
import QGrid

struct DiscoveryView<ViewModel: DiscoveryViewModeled>: View {
    
    // MARK: - Properties
    
    @ObservedObject var viewModel: ViewModel
    
    
    // MARK: - Lifecycle
    
    var body: some View {
        VStack {
            header()
            QGrid(viewModel.messages, columns: 2) { element in
                
                UserCardView(viewModel: UserCardViewModel())
                    .background(Rectangle().shadow(color: Color.black.opacity(0.5), radius: 8, x: 0, y: -4))
                    .rotate(self.viewModel.index(element).isMultiple(of: 3) ? 0 : 5)
                
            }
        }.withoutBar().background(Color.black.edgesIgnoringSafeArea(.all))
    }
    
    private func header() -> some View {
        HStack {
            VStack(alignment: .leading) {
                Text("Discovery").foregroundColor(.hOrange).font(.ultraLight(48))
                Text("Location").foregroundColor(.white).font(.thin())
            }
            Spacer()
            HapticButton(action: {}) {
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
