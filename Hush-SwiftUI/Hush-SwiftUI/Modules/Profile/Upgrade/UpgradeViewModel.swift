//
//  UpgradeViewModel.swift
//  Hush-SwiftUI
//
//  Created Dima Virych on 07.04.2020.
//  Copyright © 2020 AppServices. All rights reserved.
//

import SwiftUI
import Combine

class UpgradeViewModel: UpgradeViewModeled {
    
    // MARK: - Properties

    @Published var message = "Hellow World!"
    var uiElements: [UpgradeUIItem<AnyView>] {
        [
        UpgradeUIItem(title: "Reveal New Friends", content: image(1)),
        UpgradeUIItem(title: "Access More Filters", content: image(2)),
        UpgradeUIItem(title: "Unlimited Messaging", content: image(3)),
        UpgradeUIItem(title: "Photo Booth Rewinds", content: image(4)),
        UpgradeUIItem(title: "See Who Liked You?", content: image(5)),
        UpgradeUIItem(title: "See Who Viewed You?", content: image(6)),
        UpgradeUIItem(title: "Access Private Stories", content: image(7))
        ]
    }
    
    func updateMessage() {

        message = "New Message"
    }
    
    private func image(_ index: Int) -> AnyView {
        AnyView(Image("swipe\(index)").aspectRatio(.fit))
    }
}
