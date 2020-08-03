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
    
    func get_language_list(completion: @escaping (_ user: [Language?]?, _ error: APIError?) -> Void) {
                
        let parameters: Parameters = ["action": "getLanguageList"]
    
       let request = AF.request(endpoint, parameters: parameters)
       request.responseJSON { (response) in
            if let data = response.data {
                let json = try! JSON(data: data)
                
                switch response.result {
                case .success(_):
                    var languageList:[Language?] = []
                    var error: APIError?
                    if json["error"].int == 0 {
                        let json_users = json["languages"]

                        if (json_users.count > 0) {
                            for index in 0 ..< json_users.count {
                                let user = json_users[index]
                                let jsonData = try! user.rawData()
                                let user_data = try! JSONDecoder().decode(Language.self, from: jsonData)
                                languageList.append(user_data)
                            }
                        }
                   } else {
                       error = APIError(json["error"].intValue, json["error_m"].stringValue)
                   }
                   completion(languageList, error)
                case .failure:
                   let error = APIError(404, "Server Connection Failed")
                   completion(nil, error)
                   print("API CALL FAILED")
                }
            }
        }
    }
    
    func update_notification(notification_type: String, enable: Bool, completion: @escaping (_ result: Bool, _ error: APIError?) -> Void) {
           
        let user = Common.userInfo()
        let userId = user.id!
        let query = userId + "," + notification_type + "," + (enable ? "1" : "0")
        let parameters: Parameters = ["action": "updateNotification",
                                      "query": query]
    
        let request = AF.request(endpoint, parameters: parameters)
        request.responseJSON { (response) in
            if let data = response.data {
                let json = try! JSON(data: data)
                
                switch response.result {
                case .success(_):
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
    }
    
    func upload_image(image: UIImage, completion: @escaping (_ paths: NSDictionary?, _ error: APIError?) -> Void) {
        let imgData = image.jpegData(compressionQuality: 0.2)!

         let parameters = ["file": "image1.jpg"] //Optional for extra parameter

//        Alamofire.upload(multipartFormData: { multipartFormData in
//                multipartFormData.append(imgData, withName: "file", fileName: "image1.jpg", mimeType: "image/jpg")
//                for (key, value) in parameters {
//                        multipartFormData.append(value.data(using: String.Encoding.utf8)!, withName: key)
//                    } //Optional for extra parameters
//            },
//        to: uploadpoint)
//        { (result) in
//            switch result {
//            case .success(let upload, _, _):
//
//                upload.uploadProgress(closure: { (progress) in
//                    print("Upload Progress: \(progress.fractionCompleted)")
//                })
//
//                upload.responseSwiftyJson { response in
//
//                    switch response.result {
//                    case .success(let json):
//                        var error: APIError?
//                        let status = json["status"]
//                        if status == "ok" {
//                            let path: NSDictionary = ["path" : json["path"].stringValue, "thumb": json["thumb"].stringValue]
//                            completion(path, error)
//                        } else {
//                            error = APIError(404, "upload failed")
//                            completion(nil, error)
//                        }
//                    case .failure:
//                        var error: APIError?
//                        error = APIError(404, "connect failed")
//                        completion(nil, error)
//                    }
//                }
//
//            case .failure(let encodingError):
//                print(encodingError)
//                var error: APIError?
//                error = APIError(404, "connect failed")
//                completion(nil, error)
//            }
//        }
    }
    
    func unreadMessageCount(completion: @escaping (_ unreadMessages: Int?, _ error: APIError?) -> Void) {
        let userId: String = "user_id"
        let parameters: Parameters = ["action": "unreadMessageCount",
                                      "id": userId]
        
        let request = AF.request(endpoint, parameters: parameters)
        request.responseJSON { (response) in
            if let data = response.data {
                let json = try! JSON(data: data)
                
                switch response.result {
                case .success(_):
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
    }
    
    func add_image(path: String, thumb: String, completion: @escaping (_ imageID: String?, _ error: APIError?) -> Void) {
        let user = Common.userInfo()
        let userId = user.id!
        let parameters: Parameters = ["action": "uploadMedia",
                                      "uid": userId,
                                      "media[0][status]": "ok",
                                      "media[0][video]": "0",
                                      "media[0][path]": path,
                                      "media[0][thumb]": thumb]

//        Alamofire.request(belloo_endpoint, method: .post, parameters: parameters, encoding: URLEncoding.default, headers: nil) .responseSwiftyJson { response in
//
//                switch response.result {
//                case .success(let json):
//                    var error: APIError?
//                    var image_id: String? = nil
//                    if json["error"].int == 0 {
//                        let image_data = json["data"]
//                        image_id = image_data["id"].stringValue
//                        error = nil
//                    } else {
//                        error = APIError(json["error"].intValue, json["error_m"].stringValue)
//                    }
//                    completion(image_id, error)
//                case .failure:
//                    let error = APIError(404, "Server Connection Failed")
//                    completion(nil, error)
//                    print("API CALL FAILED")
//                }
//        }
    }
    
    func update_image(imageID: String, path: String, thumb: String, completion: @escaping (_ error: APIError?) -> Void) {
        let parameters: Parameters = ["action": "updateImage",
                                      "id": imageID,
                                      "path": path,
                                      "thumb": thumb]

        let request = AF.request(endpoint, parameters: parameters)
        request.responseJSON { (response) in
            if let data = response.data {
                let json = try! JSON(data: data)
                
                switch response.result {
                case .success(_):
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
    }
        
    func game_like(toUserID: String, like: String, completion: @escaping (_ error: APIError?) -> Void) {
        let user = Common.userInfo()
        let userId = user.id!
        let parameters: Parameters = ["action": "game_like",
                                      "uid1": userId,
                                      "uid2": toUserID,
                                      "uid3": like]

        let request = AF.request(endpoint, parameters: parameters)
        request.responseJSON { (response) in
            if let data = response.data {
                let json = try! JSON(data: data)
                
                switch response.result {
                case .success(_):
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
    }

    func add_visit(toUserID: String , completion: @escaping (_ error: APIError?) -> Void) {
        let user = Common.userInfo()
        let userId = user.id!
        let query = userId + "," + toUserID
        let parameters: Parameters = ["action": "addVisit",
                                      "query": query]
        
        let request = AF.request(endpoint, parameters: parameters)
        request.responseJSON { (response) in
            if let data = response.data {
                let json = try! JSON(data: data)
                
                switch response.result {
                case .success(_):
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
    }
    
    func update_name(name: String, completion: @escaping ( _ error: APIError?) -> Void) {
        let user = Common.userInfo()
        let userId = user.id!
        let parameters: Parameters = ["action": "updateUser",
                                      "uid": userId,
                                      "col": "name",
                                      "val": name]
        
        let request = AF.request(endpoint, parameters: parameters)
        request.responseJSON { (response) in
            if let data = response.data {
                let json = try! JSON(data: data)
                
                switch response.result {
                case .success(_):
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
    }
    
    func update_language(lang_id: String, completion: @escaping ( _ error: APIError?) -> Void) {
        let user = Common.userInfo()
        let userId = user.id!
        let parameters: Parameters = ["action": "updateUser",
                                      "uid": userId,
                                      "col": "lang",
                                      "val": lang_id]
        
        let request = AF.request(endpoint, parameters: parameters)
        request.responseJSON { (response) in
            if let data = response.data {
                let json = try! JSON(data: data)
                
                switch response.result {
                case .success(_):
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
    }
    
    func update_bio(bio: String, completion: @escaping ( _ error: APIError?) -> Void) {
        let user = Common.userInfo()
        let userId = user.id!
        let parameters: Parameters = ["action": "updateUser",
                                      "uid": userId,
                                      "col": "bio",
                                      "val": bio]
        
        let request = AF.request(endpoint, parameters: parameters)
        request.responseJSON { (response) in
            if let data = response.data {
                let json = try! JSON(data: data)
                
                switch response.result {
                case .success(_):
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
    }
    
    func update_age(age: String, completion: @escaping ( _ error: APIError?) -> Void) {
        let user = Common.userInfo()
        let userId = user.id!
        let parameters: Parameters = ["action": "updateUser",
                                      "uid": userId,
                                      "col": "age",
                                      "val": age]
        
        let request = AF.request(endpoint, parameters: parameters)
        request.responseJSON { (response) in
            if let data = response.data {
                let json = try! JSON(data: data)
                
                switch response.result {
                case .success(_):
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
    }
    
    func update_age(lower: String, upper: String, completion: @escaping (_ error: APIError?) -> Void) {
        let user = Common.userInfo()
        let userId = user.id!
        let query = userId + "," + lower + "," + upper;
        let parameters: Parameters = ["action": "updateAge",
                                      "query": query]

        let request = AF.request(endpoint, parameters: parameters)
        request.responseJSON { (response) in
            if let data = response.data {
                let json = try! JSON(data: data)
                
                switch response.result {
                case .success(_):
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
    }
    
    func update_living(living: String, completion: @escaping (_ user: User?, _ error: APIError?) -> Void) {
        let user = Common.userInfo()
        let userId = user.id!
        let query = userId + ",7," + living;
        let parameters: Parameters = ["action": "updateUserExtended",
                                      "query": query]
        
        let request = AF.request(endpoint, parameters: parameters)
        request.responseJSON { (response) in
            if let data = response.data {
                let json = try! JSON(data: data)
                
                switch response.result {
                case .success(_):
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
    }
    
    func update_sexuality(s: String, completion: @escaping (_ user: User?, _ error: APIError?) -> Void) {
        let user = Common.userInfo()
        let userId = user.id!
        let query = userId + ",2," + s;
        let parameters: Parameters = ["action": "updateUserExtended",
                                      "query": query]
        
        let request = AF.request(endpoint, parameters: parameters)
        request.responseJSON { (response) in
            if let data = response.data {
                let json = try! JSON(data: data)
                
                switch response.result {
                case .success(_):
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
    }
    
    func update_gender(gender: String, completion: @escaping ( _ error: APIError?) -> Void) {
        let user = Common.userInfo()
        let userId = user.id!
        let query = userId + "," + gender;
        let parameters: Parameters = ["action": "updateGender",
                                      "query": query]
        
        let request = AF.request(endpoint, parameters: parameters)
        request.responseJSON { (response) in
            if let data = response.data {
                let json = try! JSON(data: data)
                
                switch response.result {
                case .success(_):
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
    }
    
}
