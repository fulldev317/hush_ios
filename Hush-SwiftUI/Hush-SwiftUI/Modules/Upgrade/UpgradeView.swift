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
            ImagesCarusel(uiElements: elements())
            Spacer()
        }.background(Color.hBlack.edgesIgnoringSafeArea(.all))
    }
    
    func elements() -> [UpgradeUIItem] {
        [UpgradeUIItem(title: "1", image: UIImage(named: "image3")!),
        UpgradeUIItem(title: "2", image: UIImage(named: "image3")!),
        UpgradeUIItem(title: "3", image: UIImage(named: "image3")!),
        UpgradeUIItem(title: "4", image: UIImage(named: "image3")!),
        UpgradeUIItem(title: "5", image: UIImage(named: "image3")!),
        UpgradeUIItem(title: "6", image: UIImage(named: "image3")!),
        UpgradeUIItem(title: "7", image: UIImage(named: "image3")!),
        UpgradeUIItem(title: "8", image: UIImage(named: "image3")!)]
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
