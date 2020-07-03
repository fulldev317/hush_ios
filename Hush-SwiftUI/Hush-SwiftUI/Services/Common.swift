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
        return _address!
    }
    
    static func setMaxRangeInfo(_ range: Double) {
        _maxRange = range
    }
    
    static func maxRangeInfo() -> Double {
        return _maxRange!
    }
    
    static func setCapturedImage(_ image: UIImage) {
        _image = image
    }
    
    static func capturedImage(_ image: UIImage) -> UIImage {
        return _image!
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
    
    static func getGenderIntValue(_ gender: String) -> String {
        var nGender = "0"
        switch gender {
        case Gender.male.rawValue:
            nGender = "0"
            break
        case Gender.female.rawValue:
            nGender = "1"
            break
        case Gender.lesbian.rawValue:
            nGender = "2"
            break
        case Gender.gay.rawValue:
            nGender = "3"
            break
        default:
            nGender = "0"
        }
        return nGender
    }
    
}
