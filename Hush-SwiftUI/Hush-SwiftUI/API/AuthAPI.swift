//
//  AuthAPI.swift
//  Hush-SwiftUI
//
//  Created by iOS-dev on 27/05/2020.
//  Copyright © 2020 AppServices. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class AuthAPI: BaseAPI {
    
    static let shared: AuthAPI = AuthAPI()
    
    func login(email: String, password: String) {
        let parameters: Parameters = ["action": "login",
                                      "login_email": email,
                                      "login_pass": password,
                                      "dID": deviceUUID]
        
        api.request(endpoint, method: HTTPMethod.get, parameters: parameters, encoding: JSONEncoding.default)
            .validate(contentType: ["application/json"])
            .responseJSON { response in
                switch response.result {
                case .success:
                    //TODO
                    break
                case .failure:
                    //TODO
                    break
                }
        }
    }
    
    func register(email: String, password: String, name: String, gender: String, birthday: String, lookingFor: String, photo: String, thumb: String, city: String, country: String, latitude: Double, longitude: Double) {
        let uuid: String = UIDevice.current.identifierForVendor!.uuidString
        
        let parameters: Parameters = ["action": "register",
                                      "reg_email": email,
                                      "reg_pass": password,
                                      "reg_name": name,
                                      "reg_gender": gender,
                                      "reg_birthday": birthday,
                                      "reg_looking": lookingFor,
                                      "reg_photo": photo,
                                      "reg_thumb": thumb,
                                      "reg_city": city,
                                      "reg_country": country,
                                      "reg_lat": latitude,
                                      "reg_lng": longitude,
                                      "dID": deviceUUID]
        
        api.request(endpoint, method: HTTPMethod.get, parameters: parameters, encoding: JSONEncoding.default)
            .validate(contentType: ["application/json"])
            .responseJSON { response in
                switch response.result {
                case .success:
                    //TODO
                    break
                case .failure:
                    //TODO
                    break
                }
        }
    }
    
    func logout() {
        let parameters: Parameters = ["action": "logout",
                                      "query": deviceUUID]
        
        api.request(endpoint, method: HTTPMethod.get, parameters: parameters, encoding: JSONEncoding.default)
            .validate(contentType: ["application/json"])
            .responseJSON { response in
                switch response.result {
                case .success:
                    //TODO
                    break
                case .failure:
                    //TODO
                    break
                }
        }
    }
    
    func facebookConnect(facebookId: String, email: String, name: String, gender: String) {
        var parameters: Parameters = ["action": "fbconnect"]
        
        let query = [facebookId, email, name, gender, deviceUUID, "herefor"]
        parameters["query"] = query
        
        api.request(endpoint, method: HTTPMethod.get, parameters: parameters, encoding: JSONEncoding.default)
            .validate(contentType: ["application/json"])
            .responseJSON { response in
                switch response.result {
                case .success:
                    //TODO
                    break
                case .failure:
                    //TODO
                    break
                }
        }
    }
}
