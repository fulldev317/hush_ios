//
//  DiscoveriesSettingsViewModel.swift
//  Hush-SwiftUI
//
//  Created Dima Virych on 02.04.2020.
//  Copyright © 2020 AppServices. All rights reserved.
//

import SwiftUI
import Combine

class DiscoveriesSettingsViewModel: DiscoveriesSettingsViewModeled {
    
    // MARK: - Properties

    @Published var gender = Gender.male
    @Published var message = "Hellow World!"
    @Published var dragFlag: Bool = true
    @Published var location: String = "Los Angles, FA, US"
    @Published var closeAPISelectorCompletion: (() -> Void)?
    @Published var ageSelLower: Double = 0 {
        didSet {
            let ageLower = (Int(18 + (99 - 18) * ageSelLower))
            let ageUpper = (Int(18 + (99 - 18) * ageSelUpper))
            
            UserAPI.shared.update_age(lower: String(ageLower), upper: String(ageUpper)) { (error) in
                var user = Common.userInfo()
                if let sAge = user.sAge {
                    var ages:[String] = sAge.components(separatedBy: ",")
                    ages[0] = String(ageLower)
                    var newAge = ""
                    if ages.count == 2 {
                       newAge = ages[0] + "," + ages[1]
                    } else if ages.count == 3 {
                       newAge = ages[0] + "," + ages[1] + "," + ages[2]
                    }
                    user.sAge = newAge
                    Common.setUserInfo(user)
                }
            }
        }
    }
    @Published var ageSelUpper: Double = 1 {
        didSet {
            let ageLower = (Int(18 + (99 - 18) * ageSelLower))
            let ageUpper = (Int(18 + (99 - 18) * ageSelUpper))
            
            UserAPI.shared.update_age(lower: String(ageLower), upper: String(ageUpper)) { (error) in
                var user = Common.userInfo()
                if let sAge = user.sAge {
                    var ages:[String] = sAge.components(separatedBy: ",")
                    ages[1] = String(ageUpper)
                    var newAge = ""
                    if ages.count == 2 {
                       newAge = ages[0] + "," + ages[1]
                    } else if ages.count == 3 {
                       newAge = ages[0] + "," + ages[1] + "," + ages[2]
                    }
                    user.sAge = newAge
                    Common.setUserInfo(user)
                }
            }
        }
    }
    
    @Published var selectedDistance : Double = 1.0 {
        didSet {
            let miles = 10 + selectedDistance * 80
            let kilometers = miles * 1.6
            AuthAPI.shared.update_radius(radius: String(kilometers)) { (error) in
                Common.setMaxRangeInfo(self.selectedDistance)
                var user = Common.userInfo()
                user.sRadius = String(kilometers)
                Common.setUserInfo(user)
            }
        }
    }
    func updateMessage() {

        message = "New Message"
    }
    
    func setGender(gender: Gender) {
        self.gender = gender
        let gender_index = Common.getGenderIndexValue(gender.title)
        
        var user = Common.userInfo()
        user.gender = gender_index
        Common.setUserInfo(user)
        
        UserAPI.shared.update_gender(gender: gender_index) { ( error) in
            if (error == nil) {
                var user = Common.userInfo()
                user.gender = gender_index
                Common.setUserInfo(user)
            }
        }
    }
}
