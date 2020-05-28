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
    
    func userProfile() {
        let userId: String = "user_id"
        let parameters: Parameters = ["action": "userProfile",
                                      "id": userId]
        
        api.request(endpoint, method: HTTPMethod.get, parameters: parameters, encoding: JSONEncoding.default)
            .validate(contentType: ["application/json"])
            .responseSwiftyJson { response in
                
                switch response.result {
                case .success(let json):
                    if json["error"].int == 0 {
                        let _ = User.parseFromJson(json["user"])
                    } else {
                        let _ = APIError(json["error"].intValue, json["error_m"].stringValue)
                    }
                case .failure:
                    //TODO
                    break
                }
        }
    }
    
    func unreadMessageCount() {
        let userId: String = "user_id"
        let parameters: Parameters = ["action": "unreadMessageCount",
                                      "id": userId]
        
        api.request(endpoint, method: HTTPMethod.get, parameters: parameters, encoding: JSONEncoding.default)
            .validate(contentType: ["application/json"])
            .responseSwiftyJson { response in
                
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
    
    func messageRead() {
        let userId: String = "user_id"
        let parameters: Parameters = ["action": "messageRead",
                                      "id": userId]
        
        api.request(endpoint, method: HTTPMethod.get, parameters: parameters, encoding: JSONEncoding.default)
            .validate(contentType: ["application/json"])
            .responseSwiftyJson { response in
                
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
    
    func updateSRadius(radius: Double) {
        let userId: String = "user_id"
        var parameters: Parameters = ["action": "updateSRadius"]
        
        let query: [Any] = [userId, radius]
        parameters["query"] = query
        
        api.request(endpoint, method: HTTPMethod.get, parameters: parameters, encoding: JSONEncoding.default)
            .validate(contentType: ["application/json"])
            .responseSwiftyJson { response in
                
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
    
    func updateGender(gender: String) {
        let userId: String = "user_id"
        var parameters: Parameters = ["action": "updateGender"]
        
        let query: [Any] = [userId, gender]
        parameters["query"] = query
        
        api.request(endpoint, method: HTTPMethod.get, parameters: parameters, encoding: JSONEncoding.default)
            .validate(contentType: ["application/json"])
            .responseSwiftyJson { response in
                
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
    
    func updateUserLanguage(language: String) {
        let userId: String = "user_id"
        var parameters: Parameters = ["action": "updateUserLanguage"]
        
        let query: [Any] = [userId, language]
        parameters["query"] = query
        
        api.request(endpoint, method: HTTPMethod.get, parameters: parameters, encoding: JSONEncoding.default)
            .validate(contentType: ["application/json"])
            .responseSwiftyJson { response in
                
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
    
    func updateUserBio(bio: String, postBioUrl: String) {
        let userId: String = "user_id"
        var parameters: Parameters = ["action": "updateUserBio"]
        
        let query: [Any] = [userId, bio, postBioUrl]
        parameters["query"] = query
        
        api.request(endpoint, method: HTTPMethod.get, parameters: parameters, encoding: JSONEncoding.default)
            .validate(contentType: ["application/json"])
            .responseSwiftyJson { response in
                
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
    
    func updateUserGender(gender: String) {
        let userId: String = "user_id"
        var parameters: Parameters = ["action": "updateUserGender"]
        
        let query: [Any] = [userId, gender]
        parameters["query"] = query
        
        api.request(endpoint, method: HTTPMethod.get, parameters: parameters, encoding: JSONEncoding.default)
            .validate(contentType: ["application/json"])
            .responseSwiftyJson { response in
                
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
    
    func deletePhoto(photoId: String) {
        let userId: String = "user_id"
        var parameters: Parameters = ["action": "deletePhoto"]
        
        let query: [Any] = [userId, photoId]
        parameters["query"] = query
        
        api.request(endpoint, method: HTTPMethod.get, parameters: parameters, encoding: JSONEncoding.default)
            .validate(contentType: ["application/json"])
            .responseSwiftyJson { response in
                
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
    
    func deleteStoryAlbum(albumId: String) {
        let userId: String = "user_id"
        var parameters: Parameters = ["action": "deleteStoryAlbum"]
        
        let query: [Any] = [userId, albumId]
        parameters["query"] = query
        
        api.request(endpoint, method: HTTPMethod.get, parameters: parameters, encoding: JSONEncoding.default)
            .validate(contentType: ["application/json"])
            .responseSwiftyJson { response in
                
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
    
    func updateUserProfilePhoto(photoId: String) {
        let userId: String = "user_id"
        var parameters: Parameters = ["action": "updateUserProfilePhoto"]
        
        let query: [Any] = [userId, photoId]
        parameters["query"] = query
        
        api.request(endpoint, method: HTTPMethod.get, parameters: parameters, encoding: JSONEncoding.default)
            .validate(contentType: ["application/json"])
            .responseSwiftyJson { response in
                
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
    
    func updateUser(age: String?, birthday: String?, city: String?, country: String?, gender: String?, latitude: Double?, longitude: Double?, premium: Bool?, name: String?, verified: Bool?) {
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
                case .success:
                    //TODO
                    break
                case .failure:
                    //TODO
                    break
                }
        }
    }
    
    func updateUserExtended(questionId: String, answer: String) {
        let userId: String = "user_id"
        var parameters: Parameters = ["action": "updateUserExtended"]
        
        let query: [Any] = [userId, questionId, answer]
        parameters["query"] = query
        
        api.request(endpoint, method: HTTPMethod.get, parameters: parameters, encoding: JSONEncoding.default)
            .validate(contentType: ["application/json"])
            .responseSwiftyJson { response in
                
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
    
    func updateAge(minAge: Int, maxAge: Int) {
        let userId: String = "user_id"
        var parameters: Parameters = ["action": "updateAge"]
        
        let query: [Any] = [userId, minAge, maxAge]
        parameters["query"] = query
        
        api.request(endpoint, method: HTTPMethod.get, parameters: parameters, encoding: JSONEncoding.default)
            .validate(contentType: ["application/json"])
            .responseSwiftyJson { response in
                
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
    
    func updateLocation(latitude: Double, longitude: Double, city: String, country: String) {
        let userId: String = "user_id"
        var parameters: Parameters = ["action": "updateLocation"]
        
        let query: [Any] = [userId, latitude, longitude, city, country]
        parameters["query"] = query
        
        api.request(endpoint, method: HTTPMethod.get, parameters: parameters, encoding: JSONEncoding.default)
            .validate(contentType: ["application/json"])
            .responseSwiftyJson { response in
                
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
