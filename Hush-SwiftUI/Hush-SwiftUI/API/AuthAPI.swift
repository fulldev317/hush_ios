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
                    } else {
                        error = APIError(json["error"].intValue, json["error_m"].stringValue)
                    }
                    completion(user, error)
                case .failure:
                    let error = APIError(404, "Server Connection Failed")
                    completion(nil, error)
                    print("API CALL FAILED")
                }
        }
    }
    
    func register(email: String, password: String, username: String, name: String, gender: String, birthday: String, lookingFor: String, here: String, photo: String, thumb: String, city: String, country: String, latitude: String, longitude: String, completion: @escaping (_ user: User?, _ error: APIError?) -> Void) {

        let parameters: Parameters = ["action": "register",
                                      "reg_email": email,
                                      "reg_pass": password,
                                      "reg_username": username,
                                      "reg_name": name,
                                      "reg_gender": gender,
                                      "reg_birthday": birthday,
                                      "reg_looking": lookingFor,
                                      "reg_here_for": here,
                                      "reg_photo": photo,
                                      "reg_thumb": thumb,
                                      "reg_city": city,
                                      "reg_country": country,
                                      "reg_lat": latitude,
                                      "reg_lng": longitude,
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
                    } else {
                        user = nil
                        error = APIError(json["error"].intValue, json["error_m"][0].stringValue)
                    }
                    completion(user, error)
                case .failure:
                    let error = APIError(404, "Server Connection Failed")
                    completion(nil, error)
                    print("API CALL FAILED")
                }
        }
    }
    
    func logout(completion: @escaping (_ error: APIError?) -> Void) {
        let parameters: Parameters = ["action": "logout",
                                      "dID": deviceUUID]
        
        api.request(endpoint, method: HTTPMethod.get, parameters: parameters, encoding: URLEncoding.queryString)
            .validate(contentType: ["application/json"])
            .responseSwiftyJson { response in
                
                switch response.result {
                case .success(let json):
                    var error: APIError?

                    if (json["error"].int == 0) {
                        
                    } else {
                        error = APIError(json["error"].intValue, json["error_m"].stringValue)
                    }
                    completion(nil)
                case .failure:
                    //let error = APIError(404, "Server Connection Failed")
                    completion(nil)
                    print("API CALL FAILED")
                }
        }
    }
    
    func emailExistCheck(email: String, username: String, completion: @escaping (_ error: APIError?) -> Void) {
        let parameters: Parameters = ["action": "checkEmailUsername",
                                      "reg_email": email,
                                      "reg_username": username]
        
        api.request(endpoint, method: HTTPMethod.get, parameters: parameters, encoding: URLEncoding.queryString)
            .responseSwiftyJson { response in
                
                switch response.result {
                case .success(let json):
                    var error: APIError?
                    if json["error"].int == 0 {
                        error = nil
                    } else {
                        error = APIError(json["error"].intValue, json["error_m"].stringValue)
                    }
                    completion(error)
                case .failure:
                    let error = APIError(404, "Server Connection Failed")
                    completion(error)
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
