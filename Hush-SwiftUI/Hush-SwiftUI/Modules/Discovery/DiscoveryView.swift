//
//  DiscoveryView.swift
//  Hush-SwiftUI
//
//  Created Dima Virych on 02.04.2020.
//  Copyright © 2020 AppServices. All rights reserved.
//

import SwiftUI

struct DiscoveryView<ViewModel: DiscoveryViewModeled>: View {

    // MARK: - Properties
    
    @ObservedObject var viewModel: ViewModel
    
    
    // MARK: - Lifecycle
    
    var body: some View {
        Text(viewModel.message).onTapGesture(perform: viewModel.updateMessage)
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
