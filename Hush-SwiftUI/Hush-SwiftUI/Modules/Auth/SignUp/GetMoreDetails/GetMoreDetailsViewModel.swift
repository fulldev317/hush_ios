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
    
    func updateMessage() {

        
    }
    
    func signup(result: @escaping (Bool) -> Void) {
        
        let strGender = String(selectedGender)
        var strLookingFor = ""
        
        for guy in selectedLookingFors {
            strLookingFor = strLookingFor + String(guy) + ","
        }
        
        let photo = "https://d500.epimg.net/cincodias/imagenes/2016/07/04/lifestyle/1467646262_522853_1467646344_noticia_normal.jpg"
        let thumb = "https://d500.epimg.net/cincodias/imagenes/2016/07/04/lifestyle/1467646262_522853_1467646344_noticia_normal.jpg"
        let latitude = "27.2038"
        let longitude = "77.5011"
        
        AuthAPI.shared.register(email: email, password: password, username: username, name: name, gender: strGender, birthday: birthday, lookingFor: strLookingFor, photo: photo, thumb: thumb, city: city, country: country, latitude: latitude, longitude: longitude) { (user, error) in
            
            if let error = error {
                self.hasErrorMessage = true
                self.errorMessage = error.message
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
    
}
