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
    
    func update_notification(notification_type: String, enable: Bool, completion: @escaping (_ result: Bool, _ error: APIError?) -> Void) {
           
        let user = Common.userInfo()
        let userId = user.id!
        let query = userId + "," + notification_type + "," + (enable ? "1" : "0")
        let parameters: Parameters = ["action": "updateNotification",
                                      "query": query]
    
       api.request(endpoint, method: HTTPMethod.get, parameters: parameters, encoding: URLEncoding.queryString)
           .responseSwiftyJson { response in
               
            switch response.result {
            case .success(let json):
                var enabled = false
                var error: APIError? = nil
                if json["error"].int == 0 {
                    enabled = true
               } else {
                   error = APIError(json["error"].intValue, json["error_m"].stringValue)
               }
               completion(enabled, error)
            case .failure:
               let error = APIError(404, "Server Connection Failed")
               completion(false, error)
               print("API CALL FAILED")
            }
        }
    }
    
    func upload_image(image: UIImage, completion: @escaping (_ paths: NSDictionary?, _ error: APIError?) -> Void) {
        let imgData = image.jpegData(compressionQuality: 0.2)!

         let parameters = ["file": "image1.jpg"] //Optional for extra parameter

        Alamofire.upload(multipartFormData: { multipartFormData in
                multipartFormData.append(imgData, withName: "file", fileName: "image1.jpg", mimeType: "image/jpg")
                for (key, value) in parameters {
                        multipartFormData.append(value.data(using: String.Encoding.utf8)!, withName: key)
                    } //Optional for extra parameters
            },
        to: uploadpoint)
        { (result) in
            switch result {
            case .success(let upload, _, _):

                upload.uploadProgress(closure: { (progress) in
                    print("Upload Progress: \(progress.fractionCompleted)")
                })

                upload.responseSwiftyJson { response in
                    
                    switch response.result {
                    case .success(let json):
                        var error: APIError?
                        let status = json["status"]
                        if status == "ok" {
                            let path: NSDictionary = ["path" : json["path"].stringValue, "thumb": json["thumb"].stringValue]
                            completion(path, error)
                        } else {
                            error = APIError(404, "upload failed")
                            completion(nil, error)
                        }
                    case .failure:
                        var error: APIError?
                        error = APIError(404, "connect failed")
                        completion(nil, error)
                    }
                }

            case .failure(let encodingError):
                print(encodingError)
                var error: APIError?
                error = APIError(404, "connect failed")
                completion(nil, error)
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
    
    func update_gender(gender: String, completion: @escaping (_ error: APIError?) -> Void) {
        let user = Common.userInfo()
        let userId = user.id!
        let nGender = Common.getGenderIntValue(gender)
        let query = userId + "," + nGender;
        let parameters: Parameters = ["action": "updateGender",
                                      "query": query]
        
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
    
    func update_age(lower: String, upper: String, completion: @escaping (_ error: APIError?) -> Void) {
        let user = Common.userInfo()
        let userId = user.id!
        let query = userId + "," + lower + "," + upper;
        let parameters: Parameters = ["action": "updateAge",
                                      "query": query]
        
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
    
    func updateLocation(latitude: Double, longitude: Double, city: String, country: String, completion: @escaping (_ user: User?, _ error: APIError?) -> Void) {
        let userId: String = "user_id"
        var parameters: Parameters = ["action": "updateLocationA"]
        
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
