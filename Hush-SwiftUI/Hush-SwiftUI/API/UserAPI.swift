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
        
    func game_like(toUserID: String, like: String, completion: @escaping (_ error: APIError?) -> Void) {
        let user = Common.userInfo()
        let userId = user.id!
        let parameters: Parameters = ["action": "game_like",
                                      "uid1": userId,
                                      "uid2": toUserID,
                                      "uid3": like]

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

    func add_visit(toUserID: String , completion: @escaping (_ error: APIError?) -> Void) {
        let user = Common.userInfo()
        let userId = user.id!
        let query = userId + "," + toUserID
        let parameters: Parameters = ["action": "addVisit",
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
    
    func update_bio(bio: String, completion: @escaping ( _ error: APIError?) -> Void) {
        let user = Common.userInfo()
        let userId = user.id!
        let parameters: Parameters = ["action": "updateUser",
                                      "uid": userId,
                                      "col": "bio",
                                      "val": bio]
        
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
    
    func update_age(age: String, completion: @escaping ( _ error: APIError?) -> Void) {
        let user = Common.userInfo()
        let userId = user.id!
        let parameters: Parameters = ["action": "updateUser",
                                      "uid": userId,
                                      "col": "age",
                                      "val": age]
        
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
    
    func update_living(living: String, completion: @escaping (_ user: User?, _ error: APIError?) -> Void) {
        let user = Common.userInfo()
        let userId = user.id!
        let query = userId + ",7," + living;
        let parameters: Parameters = ["action": "updateUserExtended",
                                      "query": query]
        
        api.request(endpoint, method: HTTPMethod.get, parameters: parameters, encoding: URLEncoding.queryString)
            .responseSwiftyJson { response in
                
                switch response.result {
                case .success(let json):
                    var user: User?
                    var error: APIError?
                    if json["error"].int == 0 {
                        error = nil
                        let json_user = json["user"]
                        let jsonData = try! json_user.rawData()
                        user = try! JSONDecoder().decode(User.self, from: jsonData)
                    } else {
                        error = APIError(json["error"].intValue, json["error_m"].stringValue)
                    }
                    completion(user, error)
                case .failure:
                    let error = APIError(404, "Server Connection Failed")
                    completion(user, error)
                    print("API CALL FAILED")
                }
        }
    }
    
    func update_sexuality(s: String, completion: @escaping (_ user: User?, _ error: APIError?) -> Void) {
        let user = Common.userInfo()
        let userId = user.id!
        let query = userId + ",2," + s;
        let parameters: Parameters = ["action": "updateUserExtended",
                                      "query": query]
        
        api.request(endpoint, method: HTTPMethod.get, parameters: parameters, encoding: URLEncoding.queryString)
            .responseSwiftyJson { response in
                
                switch response.result {
                case .success(let json):
                    var user: User?
                    var error: APIError?
                    if json["error"].int == 0 {
                        error = nil
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
    
    func update_gender(gender: String, completion: @escaping ( _ error: APIError?) -> Void) {
        let user = Common.userInfo()
        let userId = user.id!
        let query = userId + "," + gender;
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
    
}
