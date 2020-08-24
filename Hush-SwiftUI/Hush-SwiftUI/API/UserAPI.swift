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
    
    func update_premium(duration: String, completion: @escaping (_ error: APIError?) -> Void) {
                
        let user = Common.userInfo()
        let uid = user.id!
        let parameters: Parameters = ["action": "updatePremium",
                                      "uid": uid,
                                      "col": "premium",
                                      "val": duration]
    
        let request = AF.request(endpoint, method: .post, parameters: parameters)
        request.responseJSON { (response) in
            if let data = response.data {
                do {
                    let json = try JSON(data: data)
                    
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
                } catch {
                    completion(APIError(404, "Server Connection Failed"))
                }
            } else {
               completion(APIError(404, "Server Connection Failed"))
            }
        }
    }
    
    func block_user(report_id: String, completion: @escaping (_ error: APIError?) -> Void) {
                
        let user = Common.userInfo()
        let uid = user.id!
        let parameters: Parameters = ["action": "block",
                                      "uid1": uid,
                                      "uid2": report_id]
    
       let request = AF.request(endpoint, parameters: parameters)
       request.responseJSON { (response) in
            if let data = response.data {
                do {
                    let json = try JSON(data: data)
                    
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
                } catch {
                    completion(APIError(404, "Server Connection Failed"))
                }
            } else {
               completion(APIError(404, "Server Connection Failed"))
            }
        }
    }
    
    func report_user(report_id: String, report_reason: String, completion: @escaping (_ error: APIError?) -> Void) {
                
        let user = Common.userInfo()
        let uid = user.id!
        let parameters: Parameters = ["action": "report",
                                      "uid1": uid,
                                      "uid2": report_id,
                                      "reason": report_reason]
    
       let request = AF.request(endpoint, parameters: parameters)
       request.responseJSON { (response) in
            if let data = response.data {
                do {
                    let json = try JSON(data: data)
                    
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
                } catch {
                    completion(APIError(404, "Server Connection Failed"))
                }
            } else {
                completion(APIError(404, "Server Connection Failed"))
            }
        }
    }
    
    func report_reason_list(completion: @escaping (_ user: [String]?, _ error: APIError?) -> Void) {
                
        let user = Common.userInfo()
        let parameters: Parameters = ["action": "reportReasonList",
                                      "langid": user.lang!]
    
       let request = AF.request(endpoint, parameters: parameters)
       request.responseJSON { (response) in
            if let data = response.data {
                do {
                    let json = try JSON(data: data)
                    
                    switch response.result {
                    case .success(_):
                        var reasonList:[String] = []
                        var error: APIError?
                        if json["error"].int == 0 {
                            let json_list = json["reportList"]

                            if (json_list.count > 0) {
                                for index in 0 ..< json_list.count {
                                    let list = json_list[index]
                                    let reason_data = list["text"]
                                    let reason: String = reason_data.rawString()!
                                    reasonList.append(reason)
                                }
                            }
                       } else {
                           error = APIError(json["error"].intValue, json["error_m"].stringValue)
                       }
                       completion(reasonList, error)
                    case .failure:
                       let error = APIError(404, "Server Connection Failed")
                       completion(nil, error)
                       print("API CALL FAILED")
                    }
                } catch {
                    completion(nil, APIError(404, "Server Connection Failed"))
                }
            } else {
                completion(nil, APIError(404, "Server Connection Failed"))
            }
        }
    }
    
    func get_language_list(completion: @escaping (_ user: [Language?]?, _ error: APIError?) -> Void) {
                
        let parameters: Parameters = ["action": "getLanguageList"]
    
       let request = AF.request(endpoint, parameters: parameters)
       request.responseJSON { (response) in
            if let data = response.data {
                do {
                    let json = try JSON(data: data)
                    
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
                } catch {
                    completion(nil, APIError(404, "Server Connection Failed"))
                }
            } else {
                completion(nil, APIError(404, "Server Connection Failed"))
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
                do {
                    let json = try JSON(data: data)
                    
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
                } catch {
                    completion(false, APIError(404, "Server Connection Failed"))
                }
            } else {
                completion(false, APIError(404, "Server Connection Failed"))
            }
        }
    }
    
    func upload_image(image: UIImage, completion: @escaping (_ paths: NSDictionary?, _ error: APIError?) -> Void) {
        let imgData = image.jpegData(compressionQuality: 0.2)!

         let parameters = ["file": "image1.jpg"] //Optional for extra parameter

        AF.upload(multipartFormData: { mulitpartFormData in
            mulitpartFormData.append(imgData, withName: "file", fileName: "image1.jpg", mimeType: "image/jpg")

             for (key, value) in parameters {
                mulitpartFormData.append(value.data(using: String.Encoding.utf8)!, withName: key)
            }
        }, to: uploadpoint)
            .uploadProgress(queue: .main, closure: { (progress) in
                print("Upload Progress: \(progress.fractionCompleted)")
            })
            .response { (response) in
                if let data = response.data {
                    do {
                        let json = try JSON(data: data)
                        
                        switch response.result {
                        case .success(_):
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
                    } catch {
                        completion(nil, APIError(404, "Server Connection Failed"))
                    }
                } else {
                    completion(nil, APIError(404, "Server Connection Failed"))
                }
        }
    }
        
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
    
    
    func unreadMessageCount(completion: @escaping (_ unreadMessages: Int?, _ error: APIError?) -> Void) {
        let userId: String = "user_id"
        let parameters: Parameters = ["action": "unreadMessageCount",
                                      "id": userId]
        
        let request = AF.request(endpoint, parameters: parameters)
        request.responseJSON { (response) in
            if let data = response.data {
                do {
                    let json = try JSON(data: data)
                    
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
                } catch {
                    completion(nil, APIError(404, "Server Connection Failed"))
                }
            } else {
                completion(nil, APIError(404, "Server Connection Failed"))
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
        let request = AF.request(belloo_endpoint, method: .post, parameters : parameters)
        request.responseJSON { (response) in
            if let data = response.data {
                do {
                   let json = try JSON(data: data)
                   
                   switch response.result {
                   case .success(_):
                        var error: APIError?
                        var image_id: String? = nil
                        if json["error"].int == 0 {
                            let image_data = json["data"]
                            image_id = image_data["id"].stringValue
                            error = nil
                        } else {
                            error = APIError(json["error"].intValue, json["error_m"].stringValue)
                        }
                        completion(image_id, error)
                    case .failure:
                        let error = APIError(404, "Server Connection Failed")
                        completion(nil, error)
                        print("API CALL FAILED")
                    }
                } catch {
                    completion(nil, APIError(404, "Server Connection Failed"))
                }
            } else {
                completion(nil, APIError(404, "Server Connection Failed"))
            }
        }
    }
    
    func update_image(imageID: String, path: String, thumb: String, completion: @escaping (_ error: APIError?) -> Void) {
        let parameters: Parameters = ["action": "updateImage",
                                      "id": imageID,
                                      "path": path,
                                      "thumb": thumb]

        let request = AF.request(endpoint, method: .post, parameters: parameters)
        request.responseJSON { (response) in
            if let data = response.data {
                do {
                    let json = try JSON(data: data)
                    
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
                } catch {
                    completion(APIError(404, "Server Connection Failed"))
                }
            } else {
                completion(APIError(404, "Server Connection Failed"))
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
                do {
                    let json = try JSON(data: data)
                    
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
                } catch {
                    let error = APIError(404, "Server Connection Failed")
                                           completion(error)
                }
            } else {
                var error: APIError?
                error = APIError(404, "connect failed")
                completion(error)
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
                do {
                    let json = try JSON(data: data)
                    
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
                } catch {
                    completion(APIError(404, "Server Connection Failed"))
                }
            } else {
                completion(APIError(404, "Server Connection Failed"))
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
                do {
                let json = try JSON(data: data)
                
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
                } catch {
                    completion(APIError(404, "Server Connection Failed"))
                }
            } else {
                completion(APIError(404, "Server Connection Failed"))
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
                do {
                    let json = try JSON(data: data)
                    
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
                } catch {
                    completion(APIError(404, "Server Connection Failed"))
                }
            } else {
                completion(APIError(404, "Server Connection Failed"))
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
                do {
                    let json = try JSON(data: data)
                    
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
                } catch {
                    completion(APIError(404, "Server Connection Failed"))
                }
            } else {
                completion(APIError(404, "Server Connection Failed"))
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
                do {
                    let json = try JSON(data: data)
                    
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
                } catch {
                    completion(APIError(404, "Server Connection Failed"))
                }
            } else {
               completion(APIError(404, "Server Connection Failed"))
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
                do {
                    let json = try JSON(data: data)
                    
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
                } catch {
                    completion(APIError(404, "Server Connection Failed"))
                }
            } else {
                completion(APIError(404, "Server Connection Failed"))
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
                do {
                    let json = try JSON(data: data)
                    
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
                } catch {
                    completion(nil, APIError(404, "Server Connection Failed"))
                }
            } else {
                completion(nil, APIError(404, "Server Connection Failed"))
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
                do {
                    let json = try JSON(data: data)
                    
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
                } catch {
                    completion(nil, APIError(404, "Server Connection Failed"))
                }
            } else {
                completion(nil, APIError(404, "Server Connection Failed"))
            }
        }
    }
    
    func update_gender(gender: String, completion: @escaping ( _ error: APIError?) -> Void) {
        let user = Common.userInfo()
        let userId = user.id!
        let parameters: Parameters = ["action": "updateGender",
                                      "uid": userId,
                                      "s_gender": gender]
        
        let request = AF.request(endpoint, parameters: parameters)
        request.responseJSON { (response) in
            if let data = response.data {
                do {
                    let json = try JSON(data: data)
                    
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
                } catch {
                    completion(APIError(404, "Server Connection Failed"))
                }
            } else {
               completion(APIError(404, "Server Connection Failed"))
            }
        }
    }
    
    func update_user_gender(gender: String, completion: @escaping ( _ error: APIError?) -> Void) {
        let user = Common.userInfo()
        let userId = user.id!
        let query = userId + "," + gender
        let parameters: Parameters = ["action": "updateUserGender",
                                      "query": query]
        
        let request = AF.request(endpoint, parameters: parameters)
        request.responseJSON { (response) in
            if let data = response.data {
                do {
                    let json = try JSON(data: data)
                    
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
                } catch {
                    completion(APIError(404, "Server Connection Failed"))
                }
            } else {
               completion(APIError(404, "Server Connection Failed"))
            }
        }
    }
}
