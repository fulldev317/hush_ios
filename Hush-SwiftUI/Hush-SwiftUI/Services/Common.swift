//
//  Common.swift
//  Hush-SwiftUI
//
//  Created by fulldev on 6/11/20.
//  Copyright © 2020 AppServices. All rights reserved.
//

import Foundation
import UIKit

var _user: User? = User()
var _address: String? = "London, UK"
var _lowAge: Double? = 0.0
var _upperAge: Double? = 1.0
var _maxRange: Double? = 0.0
var _image: UIImage?
var _block: Bool?
var _premium: Bool?
var _isMessageLoaded: Bool? = false
var _chatMessage: [HushMessage]?
let ISiPhone11 = SCREEN_HEIGHT >= 896
let ISiPhoneX = SCREEN_HEIGHT >= 812
let ISiPhonePlus = SCREEN_WIDTH == 414
let ISiPhone5 = SCREEN_WIDTH == 320
let ISiPhone8 = SCREEN_HEIGHT == 667

class Common: NSObject {
    static func setUserInfo(_ user: User) {
        _user = user
    }
    
    static func userInfo() -> User {
        return _user ?? User()
    }
    
    static func setAddressInfo(_ address: String) {
        _address = address
    }
    
    static func addressInfo() -> String {
        return _address ?? ""
    }
        
    static func setMessageLoaded(loaded: Bool) {
        _isMessageLoaded = loaded
    }
    
    static func messageLoaded() -> Bool {
        return _isMessageLoaded ?? false
    }
    
    static func setChatMessage(message: [HushMessage]) {
        _chatMessage = message
    }
    
    static func chatMessage() -> [HushMessage] {
        return _chatMessage ?? []
    }
    
    static func setMaxRangeInfo(_ range: Double) {
        _maxRange = range
    }
    
    static func maxRangeInfo() -> Double {
        return _maxRange ?? 1.0
    }
    
    static func setCapturedImage(_ image: UIImage) {
        _image = image
    }
    
    static func capturedImage(_ image: UIImage) -> UIImage {
        return _image!
    }
    
    static func setUserBlocked(_ block: Bool) {
        _block = block
    }
    
    static func userBlocked() -> Bool {
        return _block ?? false
    }
    
    static func setCurrentTab(tab: HushTabs) {
        let tabValue = tab.rawValue
        UserDefaults.standard.set(tabValue, forKey: "current_tab")
    }

    static func currentTab() -> HushTabs {
        let tab: Int? = UserDefaults.standard.integer(forKey: "current_tab")
        if tab == nil {
            return HushTabs.carusel
        }
        switch(tab) {
        case 0:
            return HushTabs.discoveries
        case 1:
            return HushTabs.stories
        case 2:
            return HushTabs.carusel
        case 3:
            return HushTabs.chats
        case 4:
            return HushTabs.profile
        default:
            return HushTabs.carusel
        }
        
    }
    
    static func setPremium(_ premium: Bool) {
        UserDefaults.standard.set(premium, forKey: "premium")
    }
    
    static func premium() -> Bool {
        let premium: Bool? = UserDefaults.standard.bool(forKey: "premium")
        return premium ?? false
    }
    
    static func loadPhotoBooth() -> Bool {
        let photobooth: Bool? = UserDefaults.standard.bool(forKey: "photobooth")
        return photobooth ?? false
    }
    
    static func setLoadPhotoBooth(photobooth: Bool) {
        UserDefaults.standard.set(photobooth, forKey: "photobooth")
    }
    
    static func getLowerAge() -> Double {
        if let user = _user {
            if let sAge = user.sAge {
                let ages:[String] = sAge.components(separatedBy: ",")
                if (ages.count > 2) {
                    let s_age = ages[0]
                    var d_s_age = Double(s_age)!
                    d_s_age = d_s_age - 18
                    d_s_age = d_s_age / (99 - 18)
                    
                    if (d_s_age > 1) {
                        d_s_age = 1
                    }
                    return d_s_age
                }
            }
        }
        return 0
    }
    
    static func getUpperAge() -> Double {
        if let user = _user {
            if let sAge = user.sAge {
                let ages:[String] = sAge.components(separatedBy: ",")
                if (ages.count > 2) {
                    let e_age = ages[1]
                    var d_e_age = Double(e_age)!
                    d_e_age = d_e_age - 18
                    d_e_age = d_e_age / (99 - 18)
                    
                    if (d_e_age > 1) {
                        d_e_age = 1
                    }
                    return d_e_age
                }
            }
        }
        return 0
    }
    
    static func getDistance() -> Double {
        if let user = _user {
            if let sRadius = user.sRadius {
                var d_radius = Double(sRadius)!
                d_radius = d_radius / 1.6
                d_radius = d_radius - 10
                d_radius = d_radius / 80
                if d_radius > 1 {
                   d_radius = 1
                }
                return d_radius
            }
        }
        return 0.5
    }
    

    static func handleErrorMessage(_ message: String) -> String {
        var errMsg = ""
        if message.contains("Reg city") {
           errMsg = "The City field required"
        } else if message.contains("Reg country") {
           errMsg = "The Country field required"
        }
        else {
           errMsg = message
        }
        return errMsg
    }
    
    static func getGenderIndexValue(_ gender: String) -> String {
        var nGender = "1"
        switch gender.lowercased() {
        case Gender.male.rawValue:
            nGender = "1"
            break
        case Gender.female.rawValue:
            nGender = "2"
            break
        case Gender.lesbian.rawValue:
            nGender = "3"
            break
        case Gender.gay.rawValue:
            nGender = "4"
            break
        default:
            nGender = "1"
        }
        return nGender
    }
    
    static func getSexIndexValue(_ sex: String) -> String {
        var nSex = "1"
        switch sex {
        case Sex.gay.rawValue:
            nSex = "1"
            break
        case Sex.open.rawValue:
            nSex = "2"
            break
        case Sex.straight.rawValue:
            nSex = "3"
            break
        case Sex.bisexual.rawValue:
            nSex = "4"
            break
        default:
            nSex = "1"
        }
        return nSex
    }
    
    static func getLivingIndexValue(_ living: String) -> String {
        var nLiving = "1"
        switch living {
        case Living.alone.rawValue:
            nLiving = "1"
            break
        case Living.parent.rawValue:
            nLiving = "2"
            break
        case Living.partner.rawValue:
            nLiving = "3"
            break
        case Living.student.rawValue:
            nLiving = "4"
            break
        default:
            nLiving = "1"
        }
        return nLiving
    }
    
    static func convertStringToJSON(jsonString: String) ->  [Dictionary<String,Any>] {
        let data = jsonString.data(using: .utf8)!
        do {
            if let jsonArray = try JSONSerialization.jsonObject(with: data, options : .allowFragments) as? [Dictionary<String,Any>]
            {
                print(jsonArray) // use the json here
                return jsonArray
            } else {
                print("bad json")
                return []
            }
        } catch let error as NSError {
            print(error)
            return []
        }
    }
    
    static func userNameValid(name: String) -> Bool {
        if name.count == 0 {
            return false
        }
        let names = name.components(separatedBy: "@")
        if (names.count > 1) {
            return false
        }
        if Int(name) != nil {
            return false
        }
        
        var num_cnt = 0
        for i in 0..<name.count {
            let c: Character = name[name.index(name.startIndex, offsetBy: i)]
            if c.isNumber {
                num_cnt += 1
            }
        }
        if num_cnt > 3 {
            return false
        }
        return true
    }
}
