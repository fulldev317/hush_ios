//
//  GetMoreDetailsViewModel.swift
//  Hush-SwiftUI
//
//  Created Dima Virych on 31.03.2020.
//  Copyright © 2020 AppServices. All rights reserved.
//

import SwiftUI
import Combine

class GetMoreDetailsViewModel: GetMoreDetailsViewModeled {
    
    var name: String
    var username: String
    var email: String
    var password: String
    var image: UIImage
    
    @Published var hasErrorMessage = false
    @Published var errorMessage = ""

    init(name: String, username: String, email: String, password: String, image: UIImage) {
        self.name = name
        self.username = username
        self.email = email
        self.password = password
        self.image = image
                
        var countires: [String] = []
        for code in NSLocale.isoCountryCodes {
            let id = NSLocale.localeIdentifier(fromComponents: [NSLocale.Key.countryCode.rawValue: code])
            let name = NSLocale(localeIdentifier: "en_UK").displayName(forKey: NSLocale.Key.identifier, value: id) ?? "Country not found for code: \(code)"
            countires.append(name)
        }
        locations = countires
               
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
    @Published var closeAPISelectorCompletion: (() -> Void)?
    @Published var locations: [String] = [
        "London, EN, UK",
        "Palo Alto, CA, US",
        "Los Angeles, CA, US",
    ]
    
    func updateMessage() {
        
        
    }
    
    func signup(birth: String, result: @escaping (Bool) -> Void) {
        
        let strGender = String(selectedGender)
        var strWhatFor = ""
        for selected in selectedWhatFor {
            strWhatFor = strWhatFor + String(selected) + ","
        }
        strWhatFor = String(strWhatFor.dropLast())
        var strLookingFor = ""
        for selected in selectedLookingFors {
            strLookingFor = strLookingFor + String(selected) + ","
        }
        strLookingFor = String(strLookingFor.dropLast())
        let photo = "https://d500.epimg.net/cincodias/imagenes/2016/07/04/lifestyle/1467646262_522853_1467646344_noticia_normal.jpg"
        let thumb = "https://d500.epimg.net/cincodias/imagenes/2016/07/04/lifestyle/1467646262_522853_1467646344_noticia_normal.jpg"
        let latitude = "27.2038"
        let longitude = "77.5011"
        let address = country
        AuthAPI.shared.register(email: email, password: password, username: username, name: name, gender: strGender, birthday: birth, lookingFor: strLookingFor, here: strWhatFor, photo: photo, thumb: thumb, address: address, latitude: latitude, longitude: longitude) { (user, error) in
            
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
                
                let jsonData = try! JSONEncoder().encode(user)
                let jsonString = String(data:jsonData, encoding: .utf8)!
                
                let currentUser = UserDefault(.currentUser, default: "")
                currentUser.wrappedValue = jsonString

                result(true)
            }
        }
    
    }
    
    func getWiFiAddress() -> String? {
        var address : String?

        // Get list of all interfaces on the local machine:
        var ifaddr : UnsafeMutablePointer<ifaddrs>?
        guard getifaddrs(&ifaddr) == 0 else { return nil }
        guard let firstAddr = ifaddr else { return nil }

        // For each interface ...
        for ifptr in sequence(first: firstAddr, next: { $0.pointee.ifa_next }) {
            let interface = ifptr.pointee

            // Check for IPv4 or IPv6 interface:
            let addrFamily = interface.ifa_addr.pointee.sa_family
            if addrFamily == UInt8(AF_INET) || addrFamily == UInt8(AF_INET6) {

                // Check interface name:
                let name = String(cString: interface.ifa_name)
                if  name == "en0" {

                    // Convert interface address to a human readable string:
                    var hostname = [CChar](repeating: 0, count: Int(NI_MAXHOST))
                    getnameinfo(interface.ifa_addr, socklen_t(interface.ifa_addr.pointee.sa_len),
                                &hostname, socklen_t(hostname.count),
                                nil, socklen_t(0), NI_NUMERICHOST)
                    address = String(cString: hostname)
                }
            }
        }
        freeifaddrs(ifaddr)

        return address
    }
    
    
}
