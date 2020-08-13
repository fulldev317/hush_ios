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

class UpgradeViewModel: UpgradeViewModeled {
    
    // MARK: - Properties

    @Published var message = "Hellow World!"
    @Published var showingIndicator = false

    @Published var oneWeek = true
    @Published var oneMonth = true
    @Published var threeMonth = true
    @Published var showAlert = false
    
    var isMatchPremium = false
    
    var offering: Purchases.Offering? = nil

    var uiMatchElements: [UpgradeUIItem<AnyView>] {
        [
        //UpgradeUIItem(title: "Reveal New Friends", content: image(1)),
        UpgradeUIItem(title: "Unlimited Messaging", content: image(3)),
        UpgradeUIItem(title: "Access More Filters", content: image(2)),
        //UpgradeUIItem(title: "Photo Booth Rewinds", content: image(4)),
        UpgradeUIItem(title: "See Who Liked You?", content: image(5)),
        UpgradeUIItem(title: "See Who Viewed You?", content: image(6)),
        //UpgradeUIItem(title: "Access Private Stories", content: image(7))
        ]
    }
    
    var uiMessageElements: [UpgradeUIItem<AnyView>] {
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
        
    init(isMatched: Bool) {
        
        self.isMatchPremium = isMatched
        
        self.showingIndicator = true
        Purchases.shared.offerings { (offerings, error) in
            self.showingIndicator = false

            if let offerings = offerings {
                if let offer = offerings.current {
                    self.offering = offer
                }
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
    
    func getElements() -> [UpgradeUIItem<AnyView>] {
        if (isMatchPremium) {
            return uiMatchElements
        }
        return uiMessageElements
    }
    
    func upgradeOneWeek(result: @escaping (Bool, String) -> Void) {
        purchasePackage(index: 0) { (alert, message) in
            result(alert, message)
        }
    }
    
    func upgradeOneMonth(result: @escaping (Bool, String) -> Void) {
        purchasePackage(index: 1) { (alert, message) in
            result(alert, message)
        }
    }
    
    func upgradeThreeMonth(result: @escaping (Bool, String) -> Void) {
        purchasePackage(index: 2) { (alert, message) in
            result(alert, message)
        }
    }
    
    func purchasePackage(index: Int, result: @escaping (Bool, String) -> Void) {
        if let offering = self.offering {
            let packages = offering.availablePackages
            if (packages.count > 0) {
                let package = packages[index]
                Purchases.shared.purchasePackage(package) { (transaction, purchaserInfo, error, userCancelled) in
                    if let error = error {
                        if !userCancelled {
                            result(true, error.localizedDescription)
                        } else {
                            result(false, "")
                        }
                    } else {
                        if purchaserInfo?.entitlements["pro"]?.isActive == true {
                            // Unlock that great "pro" content
                            Common.setPremium(true)
                            self.upgradeUserPremium(index: index)
                            result(true, "success")
                        } else {
                            result(false, "")
                        }
                    }
                    
                }
            }
        }
    }
    
    func upgradeUserPremium(index: Int) {
        var duration = "7"
        if (index == 0) {
            duration = "7"
        } else if (index == 1) {
            duration = "30"
        } else if (index == 2) {
            duration = "90"
        }
        UserAPI.shared.update_premium(duration: duration) { (error) in
            if (error == nil) {
                
            }
        }
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
