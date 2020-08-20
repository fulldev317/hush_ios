//
//  GetMoreDetailsViewModel.swift
//  Hush-SwiftUI
//
//  Created Dima Virych on 31.03.2020.
//  Copyright © 2020 AppServices. All rights reserved.
//

import SwiftUI
import Combine
import PushNotifications

class GetMoreDetailsViewModel: GetMoreDetailsViewModeled {
    
    var name: String
    var username: String
    var email: String
    var password: String
    var image: UIImage
    var imagePath: String
    var imageThumb: String
    
    @Published var hasErrorMessage = false
    @Published var errorMessage = ""

    init(name: String, username: String, email: String, password: String, image: UIImage, imagePath: String, imageThumb: String) {
        self.name = name
        self.username = username
        self.email = email
        self.password = password
        self.image = image
        self.imagePath = imagePath
        self.imageThumb = imageThumb
        
        var countires: [String] = []
        for code in NSLocale.isoCountryCodes {
            let id = NSLocale.localeIdentifier(fromComponents: [NSLocale.Key.countryCode.rawValue: code])
            let name = NSLocale(localeIdentifier: "en_UK").displayName(forKey: NSLocale.Key.identifier, value: id) ?? "Country not found for code: \(code)"
            countires.append(name)
        }
        locations = countires
        
        self.getLocation { (location) in
            if (location.count > 0) {
                self.location = location
                self.getGeoCode(address: location)
            }
        }
    }
    
    // MARK: - Properties
    
    @Published var whatFors: [String] = ["Fun", "Chat", "Hookup", "Date"]
    @Published var selectedWhatFor: Set<Int> = []
    
    @Published var genders: [String] = ["Male", "Female", "A Couple", "Gay"]
    @Published var selectedGender: Int = 0
    
    @Published var lookingFors: [String] = ["Males", "Females", "Couples", "Gays"]
    @Published var selectedLookingFors: Set<Int> = []
    
    @Published var birthday = "Enter your Date of Birth"
    @Published var country = ""
    @Published var city = ""
    @Published var location = ""
    @Published var latitude = ""
    @Published var longitude = ""
    @Published var closeAPISelectorCompletion: (() -> Void)?
    @Published var locations: [String] = [
        "London, EN, UK",
        "Palo Alto, CA, US",
        "Los Angeles, CA, US",
    ]
    @Published var editingLocation: Bool = false
    
    func updateMessage() {
    }
    
    func signup(birth: String, result: @escaping (Bool) -> Void) {
        
        let strGender = String(selectedGender + 1)
        var strWhatFor = ""
        for selected in selectedWhatFor {
            strWhatFor = strWhatFor + String(selected + 1) + ","
        }
        strWhatFor = String(strWhatFor.dropLast())
        var strLookingFor = ""
        for selected in selectedLookingFors {
            strLookingFor = strLookingFor + String(selected + 1) + ","
        }
        strLookingFor = String(strLookingFor.dropLast())
        let photo = imagePath
        let thumb = imageThumb
        let latitude = self.latitude
        let longitude = self.longitude
        let address = self.location
        let city = self.location.components(separatedBy: ",")[0]
        
        AuthAPI.shared.register(email: email, password: password, username: username, name: name, gender: strGender, birthday: birth, lookingFor: strLookingFor, here: strWhatFor, photo: photo, thumb: thumb, address: address, city: city, latitude: latitude, longitude: longitude) { (user, error) in
            
            if let error = error {
                self.hasErrorMessage = true
                self.errorMessage = Common.handleErrorMessage(error.message)
                result(false)
                
            } else if let user = user {
                self.hasErrorMessage = false
                self.errorMessage = ""
                let isLoggedIn = UserDefault(.isLoggedIn, default: false)
                isLoggedIn.wrappedValue = true
                
                Common.setUserInfo(user)
                Common.setAddressInfo(user.address ?? "")
                if let s_gender = user.sGender {
                    Common.setSGenderString(gender: s_gender)
                }
                //Common.setCurrentTab(tab: HushTabs.carusel)
                
                let jsonData = try! JSONEncoder().encode(user)
                let jsonString = String(data:jsonData, encoding: .utf8)!
                
                let currentUser = UserDefault(.currentUser, default: "")
                currentUser.wrappedValue = jsonString

                self.setPusherId(userId: user.id!)
                
                result(true)
            }
        }
    
    }
    
    func getGeoCode(address: String) {
        AuthAPI.shared.get_geocode(address: address) { lat, lng in
            if lat!.count > 0 && lng!.count > 0 {
                self.latitude = lat!
                self.longitude = lng!
            }
        }
    }
    
    func getLocation(result: @escaping (String) -> Void){
        AuthAPI.shared.get_location { (location, error) in
            if (error == nil) {
                result(location!)
            } else {
                result("")
            }
        }
    }
    
    func setPusherId(userId: String) {
        let tokenProvider = BeamsTokenProvider(authURL: "https://www.hushdating.app/requests/appapi.php") { () -> AuthData in
            let sessionToken = "E9AF1A15E2F1369770BCCE93A8B8EEC46A41ABE2617E43DC17F5337603A239D8"
            let headers = ["Authorization": "Bearer \(sessionToken)"] // Headers your auth endpoint needs
            let queryParams: [String: String] = ["action":"getBeamsToken", "uid":userId] // URL query params your auth endpoint needs
            return AuthData(headers: headers, queryParams: queryParams)
        }
        
        pushNotifications.setUserId(userId, tokenProvider: tokenProvider, completion: { error in
            guard error == nil else {
                print(error.debugDescription)
                return
            }
            print("Successfully authenticated with Pusher Beams")
        })
    }
    
}
