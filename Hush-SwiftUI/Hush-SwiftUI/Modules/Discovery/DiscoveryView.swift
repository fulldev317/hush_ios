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
    
    
    // MARK: - Lifecycle
    
    var body: some View {
        VStack(spacing: 0) {
            
            QGrid(viewModel.messages, columns: 2) { element in
                
                NavigationLink(destination: UserProfileView(viewModel: UserProfileViewModel()).withoutBar()) {
                    PolaroidCard(image: UIImage(named: "image3")!, cardWidth: SCREEN_WIDTH / 2, bottom: self.bottomView(element))
                    .background(Rectangle().shadow(color: Color.black.opacity(0.5), radius: 8, x: 0, y: -4))
                    .rotate(self.viewModel.index(element).isMultiple(of: 3) ? 0 : -5)
                }.buttonStyle(PlainButtonStyle())
            }
        }
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
