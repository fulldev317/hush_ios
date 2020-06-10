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
    
    func login(email: String, password: String, completion: @escaping (_ user: User?, _ error: APIError?) -> Void) {
        let parameters: Parameters = ["action": "login",
                                      "login_email": email,
                                      "login_pass": password,
                                      "dID": deviceUUID]
        
        api.request(endpoint, method: HTTPMethod.get, parameters: parameters, encoding: URLEncoding.queryString)
            .responseSwiftyJson { response in
                
                switch response.result {
                case .success(let json):
                    var user: User?
                    var error: APIError?
                    if json["error"].int == 0 {
                        let json_user = json["user"]
                        let jsonData = try! json_user.rawData()
                        user = try! JSONDecoder().decode(User.self, from: jsonData)
                        
                        //user = User.parseFromJson(json["user"])
                    } else {
                        error = APIError(json["error"].intValue, json["error_m"].stringValue)
                    }
                    completion(user, error)
                case .failure:
                    print("API CALL FAILED")
                }
        }
    }
    
    func register(email: String, password: String, name: String, gender: String, birthday: String, lookingFor: String, photo: String, thumb: String, city: String, country: String, latitude: Double, longitude: Double, completion: @escaping (_ user: User?, _ error: APIError?) -> Void) {
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
            .responseSwiftyJson { response in
                
                switch response.result {
                case .success(let json):
                    var user: User?
                    var error: APIError?
                    if json["error"].int == 0 {
                        //user = User.parseFromJson(json["user"])
                    } else {
                        error = APIError(json["error"].intValue, json["error_m"].stringValue)
                    }
                    completion(user, error)
                case .failure:
                    print("API CALL FAILED")
                }
        }
    }
    
    func logout(completion: @escaping () -> Void) {
        let parameters: Parameters = ["action": "logout",
                                      "query": deviceUUID]
        
        api.request(endpoint, method: HTTPMethod.get, parameters: parameters, encoding: JSONEncoding.default)
            .validate(contentType: ["application/json"])
            .responseSwiftyJson { response in
                
                switch response.result {
                case .success:
                    completion()
                case .failure:
                    print("API CALL FAILED")
                }
        }
    }
    
    func facebookConnect(facebookId: String, email: String, name: String, gender: String, completion: @escaping (_ user: User?, _ error: APIError?) -> Void) {
        var parameters: Parameters = ["action": "fbconnect"]
        
        let query = [facebookId, email, name, gender, deviceUUID, "herefor"]
        parameters["query"] = query
        
        api.request(endpoint, method: HTTPMethod.get, parameters: parameters, encoding: JSONEncoding.default)
            .validate(contentType: ["application/json"])
            .responseSwiftyJson { response in
                
                switch response.result {
                case .success(let json):
                    var user: User?
                    var error: APIError?
                    if json["error"].int == 0 {
                        //user = User.parseFromJson(json["user"])
                    } else {
                        error = APIError(json["error"].intValue, json["error_m"].stringValue)
                    }
                    completion(user, error)
                case .failure:
                    print("API CALL FAILED")
                }
        }
    }
}
