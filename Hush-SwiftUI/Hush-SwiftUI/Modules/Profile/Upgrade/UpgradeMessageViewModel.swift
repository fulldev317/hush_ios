//
//  UpgradeViewModel.swift
//  Hush-SwiftUI
//
//  Created Dima Virych on 07.04.2020.
//  Copyright © 2020 AppServices. All rights reserved.
//

import SwiftUI
import Combine
import Purchases

class UpgradeMessageViewModel: UpgradeViewModeled {
    
    // MARK: - Properties

    @Published var message = "Hellow World!"
    @Published var showingIndicator = true

    var offering: Purchases.Offering? = nil
    @Published var oneWeek = true
    @Published var oneMonth = true
    @Published var threeMonth = true
    @Published var showAlert = false

    var uiElements: [UpgradeUIItem<AnyView>] {
        [
        UpgradeUIItem(title: "Connect with Wendy", content: profile_image(0)),
        UpgradeUIItem(title: "Unlimited Messaging", content: image(3)),
        UpgradeUIItem(title: "Access More Filters", content: image(2)),
        //UpgradeUIItem(title: "Photo Booth Rewinds", content: image(4)),
        UpgradeUIItem(title: "See Who Liked You?", content: image(5)),
        UpgradeUIItem(title: "See Who Viewed You?", content: image(6)),
        //UpgradeUIItem(title: "Access Private Stories", content: image(7))
        ]
    }
    
    init() {
        self.showingIndicator = true
        Purchases.shared.offerings { (offerings, error) in
            self.showingIndicator = false

            if let offerings = offerings {
                if let offer = offerings.current {
                    self.offering = offer
                }
            }
        }
        
        Purchases.shared.purchaserInfo { (purchaserInfo, error) in
            if purchaserInfo?.entitlements.all["1_week_special.upgrade"]?.isActive == true {
                self.oneWeek = false
            }
            if purchaserInfo?.entitlements.all["1_month.upgrade"]?.isActive == true {
                self.oneMonth = false
            }
            if purchaserInfo?.entitlements.all["3_month.upgrade"]?.isActive == true {
                self.threeMonth = false
            }
        }
                                        
        //                                Purchases.shared.purchasePackage(package) { (transaction, purchaserInfo, error, userCancelled) in
        //                                    if purchaserInfo?.entitlements.all["1_week_special.upgrade"]?.isActive == true {
        //                                        // Unlock that great "pro" content
        //
        //                                    }
        //                                }
                                        
        //                                Purchases.shared.purchaserInfo { (purchaserInfo, error) in
        //                                    if purchaserInfo?.entitlements.all["1_week_special.upgrade"]?.isActive == true {
        //                                        // User is "premium"
        //                                    }
        //                                }
    }
    
    func upgradeOneWeek() {
        if let offering = self.offering {
            let packages = offering.availablePackages
            if (packages.count > 0) {
                let package = packages[0]
                Purchases.shared.purchasePackage(package) { (transaction, purchaserInfo, error, userCancelled) in
                    if purchaserInfo?.entitlements.all["1_week_special.upgrade"]?.isActive == true {
                        // Unlock that great "pro" content
                        self.showAlert = true
                    }
                }
            }
        }
    }
    
    func upgradeOneMonth() {
        
    }
    
    func upgradeThreeMonth() {
        
    }
    
    func updateMessage() {

        message = "New Message"
    }
    
    private func image(_ index: Int) -> AnyView {
        AnyView(Image("swipe\(index)").aspectRatio(.fit))
    }
    
    private func profile_image(_ index: Int) -> AnyView {
        AnyView(
            ZStack {
                Image("image3").aspectRatio(.fit).padding(.horizontal, 10)
                Image("swipe\(index)").aspectRatio(.fit)
            }
        )
    }
}

