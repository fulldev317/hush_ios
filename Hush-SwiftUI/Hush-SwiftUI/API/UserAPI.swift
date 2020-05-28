//
//  UserAPI.swift
//  Hush-SwiftUI
//
//  Created by iOS-dev on 27/05/2020.
//  Copyright © 2020 AppServices. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class UserAPI: BaseAPI {
    
    static let shared: UserAPI = UserAPI()
    
    func userProfile(completion: @escaping (_ user: User?, _ error: APIError?) -> Void) {
        let userId: String = "user_id"
        let parameters: Parameters = ["action": "userProfile",
                                      "id": userId]
        
        api.request(endpoint, method: HTTPMethod.get, parameters: parameters, encoding: JSONEncoding.default)
            .validate(contentType: ["application/json"])
            .responseSwiftyJson { response in
                
                switch response.result {
                case .success(let json):
                    var user: User?
                    var error: APIError?
                    if json["error"].int == 0 {
                        user = User.parseFromJson(json["user"])
                    } else {
                        error = APIError(json["error"].intValue, json["error_m"].stringValue)
                    }
                    completion(user, error)
                case .failure:
                    print("API CALL FAILED")
                }
        }
    }
    
    func unreadMessageCount(completion: @escaping (_ unreadMessages: Int?, _ error: APIError?) -> Void) {
        let userId: String = "user_id"
        let parameters: Parameters = ["action": "unreadMessageCount",
                                      "id": userId]
        
        api.request(endpoint, method: HTTPMethod.get, parameters: parameters, encoding: JSONEncoding.default)
            .validate(contentType: ["application/json"])
            .responseSwiftyJson { response in
                
                switch response.result {
                case .success(let json):
                    var unreadMessages: Int?
                    var error: APIError?
                    if json["error"].int == 0 {
                        unreadMessages = Int(json["unreadMessageCount"].string ?? "0") ?? 0
                    } else {
                        error = APIError(json["error"].intValue, json["error_m"].stringValue)
                    }
                    completion(unreadMessages, error)
                case .failure:
                    print("API CALL FAILED")
                }
        }
    }
    
    func messageRead(completion: @escaping () -> Void) {
        let userId: String = "user_id"
        let parameters: Parameters = ["action": "messageRead",
                                      "id": userId]
        
        api.request(endpoint, method: HTTPMethod.get, parameters: parameters, encoding: JSONEncoding.default)
            .validate(contentType: ["application/json"])
            .responseSwiftyJson { response in
                
                switch response.result {
                case .success(let json):
                    completion()
                case .failure:
                    print("API CALL FAILED")
                }
        }
    }
    
    func updateSRadius(radius: Double, completion: @escaping (_ user: User?, _ error: APIError?) -> Void) {
        let userId: String = "user_id"
        var parameters: Parameters = ["action": "updateSRadius"]
        
        let query: [Any] = [userId, radius]
        parameters["query"] = query
        
        api.request(endpoint, method: HTTPMethod.get, parameters: parameters, encoding: JSONEncoding.default)
            .validate(contentType: ["application/json"])
            .responseSwiftyJson { response in
                
                switch response.result {
                case .success(let json):
                    var user: User?
                    var error: APIError?
                    if json["error"].int == 0 {
                        user = User.parseFromJson(json["user"])
                    } else {
                        error = APIError(json["error"].intValue, json["error_m"].stringValue)
                    }
                    completion(user, error)
                case .failure:
                    print("API CALL FAILED")
                }
        }
    }
    
    func updateGender(gender: String, completion: @escaping (_ user: User?, _ error: APIError?) -> Void) {
        let userId: String = "user_id"
        var parameters: Parameters = ["action": "updateGender"]
        
        let query: [Any] = [userId, gender]
        parameters["query"] = query
        
        api.request(endpoint, method: HTTPMethod.get, parameters: parameters, encoding: JSONEncoding.default)
            .validate(contentType: ["application/json"])
            .responseSwiftyJson { response in
                
                switch response.result {
                case .success(let json):
                    var user: User?
                    var error: APIError?
                    if json["error"].int == 0 {
                        user = User.parseFromJson(json["user"])
                    } else {
                        error = APIError(json["error"].intValue, json["error_m"].stringValue)
                    }
                    completion(user, error)
                case .failure:
                    print("API CALL FAILED")
                }
        }
    }
    
    func updateUserLanguage(language: String, completion: @escaping (_ error: APIError?) -> Void) {
        let userId: String = "user_id"
        var parameters: Parameters = ["action": "updateUserLanguage"]
        
        let query: [Any] = [userId, language]
        parameters["query"] = query
        
        api.request(endpoint, method: HTTPMethod.get, parameters: parameters, encoding: JSONEncoding.default)
            .validate(contentType: ["application/json"])
            .responseSwiftyJson { response in
                
                switch response.result {
                case .success(let json):
                    var error: APIError?
                    if json["error"].int != 0 {
                        error = APIError(json["error"].intValue, json["error_m"].stringValue)
                    }
                    completion(error)
                case .failure:
                    print("API CALL FAILED")
                }
        }
    }
    
    func updateUserBio(bio: String, postBioUrl: String, completion: @escaping (_ urlMessage: String?, _ url: String?, _ error: APIError?) -> Void) {
        let userId: String = "user_id"
        var parameters: Parameters = ["action": "updateUserBio"]
        
        let query: [Any] = [userId, bio, postBioUrl]
        parameters["query"] = query
        
        api.request(endpoint, method: HTTPMethod.get, parameters: parameters, encoding: JSONEncoding.default)
            .validate(contentType: ["application/json"])
            .responseSwiftyJson { response in
                
                switch response.result {
                case .success(let json):
                    var urlMessage: String?
                    var url: String?
                    var error: APIError?
                    if json["error"].int == 0 {
                        urlMessage = json["urlMessage"].string
                        url = json["url"].string
                    } else {
                        error = APIError(json["error"].intValue, json["error_m"].stringValue)
                    }
                    completion(urlMessage, url, error)
                case .failure:
                    print("API CALL FAILED")
                }
        }
    }
    
    func deletePhoto(photoId: String, completion: @escaping (_ user: User?, _ error: APIError?) -> Void) {
        let userId: String = "user_id"
        var parameters: Parameters = ["action": "deletePhoto"]
        
        let query: [Any] = [userId, photoId]
        parameters["query"] = query
        
        api.request(endpoint, method: HTTPMethod.get, parameters: parameters, encoding: JSONEncoding.default)
            .validate(contentType: ["application/json"])
            .responseSwiftyJson { response in
                
                switch response.result {
                case .success(let json):
                    var user: User?
                    var error: APIError?
                    if json["error"].int == 0 {
                        user = User.parseFromJson(json["user"])
                    } else {
                        error = APIError(json["error"].intValue, json["error_m"].stringValue)
                    }
                    completion(user, error)
                case .failure:
                    print("API CALL FAILED")
                }
        }
    }
    
    func deleteStoryAlbum(albumId: String, completion: @escaping (_ error: APIError?) -> Void) {
        let userId: String = "user_id"
        var parameters: Parameters = ["action": "deleteStoryAlbum"]
        
        let query: [Any] = [userId, albumId]
        parameters["query"] = query
        
        api.request(endpoint, method: HTTPMethod.get, parameters: parameters, encoding: JSONEncoding.default)
            .validate(contentType: ["application/json"])
            .responseSwiftyJson { response in
                
                switch response.result {
                case .success(let json):
                    var error: APIError?
                    if json["error"].int != 0 {
                        error = APIError(json["error"].intValue, json["error_m"].stringValue)
                    }
                    completion(error)
                case .failure:
                    print("API CALL FAILED")
                }
        }
    }
    
    func updateUserProfilePhoto(photoId: String, completion: @escaping (_ user: User?, _ error: APIError?) -> Void) {
        let userId: String = "user_id"
        var parameters: Parameters = ["action": "updateUserProfilePhoto"]
        
        let query: [Any] = [userId, photoId]
        parameters["query"] = query
        
        api.request(endpoint, method: HTTPMethod.get, parameters: parameters, encoding: JSONEncoding.default)
            .validate(contentType: ["application/json"])
            .responseSwiftyJson { response in
                
                switch response.result {
                case .success(let json):
                    var user: User?
                    var error: APIError?
                    if json["error"].int == 0 {
                        user = User.parseFromJson(json["user"])
                    } else {
                        error = APIError(json["error"].intValue, json["error_m"].stringValue)
                    }
                    completion(user, error)
                case .failure:
                    print("API CALL FAILED")
                }
        }
    }
    
    func updateUser(age: String?, birthday: String?, city: String?, country: String?, gender: String?, latitude: Double?, longitude: Double?, premium: Bool?, name: String?, verified: Bool?, completion: @escaping (_ user: User?, _ error: APIError?) -> Void) {
        let userId: String = "user_id"
        var parameters: Parameters = ["action": "updateUser"]
        
        var query: [Any] = [userId]
        
        if let age = age {
            query.append(contentsOf: [age, 0])
            
        } else if let birthday = birthday {
            query.append(contentsOf: [birthday, 1])
            
        } else if let city = city {
            query.append(contentsOf: [city, 2])
            
        } else if let country = country {
            query.append(contentsOf: [country, 3])
            
        } else if let gender = gender {
            query.append(contentsOf: [gender, 4])
            
        } else if let latitude = latitude {
            query.append(contentsOf: [latitude, 5])
            
        } else if let longitude = longitude {
            query.append(contentsOf: [longitude, 6])
            
        } else if let premium = premium {
            query.append(contentsOf: [premium, 7])
            
        } else if let name = name {
            query.append(contentsOf: [name, 8])
            
        } else if let verified = verified {
            query.append(contentsOf: [verified, 9])
        }
        
        parameters["query"] = query
        
        api.request(endpoint, method: HTTPMethod.get, parameters: parameters, encoding: JSONEncoding.default)
            .validate(contentType: ["application/json"])
            .responseSwiftyJson { response in
                
                switch response.result {
                case .success(let json):
                    var user: User?
                    var error: APIError?
                    if json["error"].int == 0 {
                        user = User.parseFromJson(json["user"])
                    } else {
                        error = APIError(json["error"].intValue, json["error_m"].stringValue)
                    }
                    completion(user, error)
                case .failure:
                    print("API CALL FAILED")
                }
        }
    }
    
    func updateUserExtended(questionId: String, answer: String, completion: @escaping (_ user: User?, _ error: APIError?) -> Void) {
        let userId: String = "user_id"
        var parameters: Parameters = ["action": "updateUserExtended"]
        
        let query: [Any] = [userId, questionId, answer]
        parameters["query"] = query
        
        api.request(endpoint, method: HTTPMethod.get, parameters: parameters, encoding: JSONEncoding.default)
            .validate(contentType: ["application/json"])
            .responseSwiftyJson { response in
                
                switch response.result {
                case .success(let json):
                    var user: User?
                    var error: APIError?
                    if json["error"].int == 0 {
                        user = User.parseFromJson(json["user"])
                    } else {
                        error = APIError(json["error"].intValue, json["error_m"].stringValue)
                    }
                    completion(user, error)
                case .failure:
                    print("API CALL FAILED")
                    
                }
        }
    }
    
    func updateAge(minAge: Int, maxAge: Int, completion: @escaping (_ error: APIError?) -> Void) {
        let userId: String = "user_id"
        var parameters: Parameters = ["action": "updateAge"]
        
        let query: [Any] = [userId, minAge, maxAge]
        parameters["query"] = query
        
        api.request(endpoint, method: HTTPMethod.get, parameters: parameters, encoding: JSONEncoding.default)
            .validate(contentType: ["application/json"])
            .responseSwiftyJson { response in
                
                switch response.result {
                case .success(let json):
                    var error: APIError?
                    if json["error"].int != 0 {
                        error = APIError(json["error"].intValue, json["error_m"].stringValue)
                    }
                    completion(error)
                case .failure:
                    print("API CALL FAILED")
                }
        }
    }
    
    func updateLocation(latitude: Double, longitude: Double, city: String, country: String, completion: @escaping (_ user: User?, _ error: APIError?) -> Void) {
        let userId: String = "user_id"
        var parameters: Parameters = ["action": "updateLocation"]
        
        let query: [Any] = [userId, latitude, longitude, city, country]
        parameters["query"] = query
        
        api.request(endpoint, method: HTTPMethod.get, parameters: parameters, encoding: JSONEncoding.default)
            .validate(contentType: ["application/json"])
            .responseSwiftyJson { response in
                
                switch response.result {
                case .success(let json):
                    var user: User?
                    var error: APIError?
                    if json["error"].int == 0 {
                        user = User.parseFromJson(json["user"])
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
