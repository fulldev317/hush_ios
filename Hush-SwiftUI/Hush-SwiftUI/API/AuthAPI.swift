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
    
    func register(email: String, password: String, username: String, name: String, gender: String, birthday: String, lookingFor: String, here: String, photo: String, thumb: String, address: String,  latitude: String, longitude: String, completion: @escaping (_ user: User?, _ error: APIError?) -> Void) {

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
                                      "reg_address": address,
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
        
        let query = facebookId + "," + email + "," + name + "," + gender + "," + deviceUUID + "," + "2-3" + "," + "2-3"
        parameters["query"] = query
        
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
    
    func get_user_data(userId: String, completion: @escaping (_ user: User?, _ error: APIError?) -> Void) {
        let parameters: Parameters = ["action": "data",
                                      "query": userId]
        
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
    
    func get_address(query: String, completion: @escaping (_ address: String?) -> Void) {
        
        if query.count == 0 {
            return
        }
        
        let parameters: Parameters = ["key": "AIzaSyDciBuFvEMToHJSdzPJzxEykr6SwNU_xS8",
                                      "input": query]
        
        api.request(google_place, method: HTTPMethod.get, parameters: parameters, encoding: URLEncoding.queryString)
            .responseSwiftyJson { response in
                
                switch response.result {
                case .success(let json):
                    let predictions = json["predictions"]
                    if predictions.count == 0 {
                        completion("")
                        return
                    }
                    
                    let prediction = predictions[0]
                    let address: String = prediction["description"].string!
                    completion(address)
                    
                case .failure:
                    completion("")
                    print("API CALL FAILED")
                }
        }
    }
    
    func get_geocode(address: String, completion: @escaping (_ lat: String?, _ lng: String?) -> Void) {
        
        if address.count == 0 {
            return
        }
        
        let parameters: Parameters = ["key": "AIzaSyDciBuFvEMToHJSdzPJzxEykr6SwNU_xS8",
                                      "address": address]
        
        api.request(google_geocode, method: HTTPMethod.get, parameters: parameters, encoding: URLEncoding.queryString)
            .responseSwiftyJson { response in
                
                switch response.result {
                case .success(let json):
                    let results = json["results"]
                    if results.count == 0 {
                        completion("", "")
                        return
                    }

                    let result = results[0]
                    let geometry = result["geometry"]
                    let location = geometry["location"]
                    let lat = location["lat"].doubleValue
                    let lng = location["lng"].doubleValue
                    let strLat = String(format:"%.8f", lat)
                    let strLng = String(format:"%.8f", lng)
                    completion(strLat, strLng)
                    
                case .failure:
                    completion("", "")
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
                            let path: NSDictionary = ["path" : json["path"], "thumb": json["thumb"]]
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
}
