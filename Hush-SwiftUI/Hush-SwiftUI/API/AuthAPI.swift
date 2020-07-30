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
    
    func cuser(userId: String, completion: @escaping (_ user: User?, _ error: APIError?) -> Void) {
        
        let user = Common.userInfo()
        let myId = user.id!
        
        let parameters: Parameters = ["action": "cuser",
                                      "uid1": userId,
                                      "uid2": myId]
        
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

    func register(email: String, password: String, username: String, name: String, gender: String, birthday: String, lookingFor: String, here: String, photo: String, thumb: String, address: String, city:String, latitude: String, longitude: String, completion: @escaping (_ user: User?, _ error: APIError?) -> Void) {

        let parameters: Parameters = ["action": "registerA",
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
                                      "reg_city": city,
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
                        error = nil
                    } else {
                        error = APIError(json["error"].intValue, json["error_m"].stringValue)
                    }
                    completion(error)
                case .failure:
                    //let error = APIError(404, "Server Connection Failed")
                    completion(nil)
                    print("API CALL FAILED")
                }
        }
    }
    
    func emailExistCheck(name: String, email: String, username: String, password: String, completion: @escaping (_ error: APIError?) -> Void) {
        let parameters: Parameters = ["action": "checkEmailUsername",
                                      "reg_email": email,
                                      "reg_name": name,
                                      "reg_pass": password,
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
    
    func discovery(uid: String, location: String, gender: String?, max_distance: String?, age_range: String?, check_online: String, completion: @escaping (_ user: [User?]?, _ error: APIError?) -> Void) {
        
        var param_gender: String = ""
        if gender != nil {
            param_gender = gender!
        }
        
        var param_max_distance: String = "50"
        if max_distance != nil {
            param_max_distance = max_distance!
        }
        
        var param_age: String = "18,40"
        if age_range != nil {
            param_age = age_range!
        }
             
        let parameters: Parameters = ["action": "discover",
                                      "uid": uid,
                                      "check_online": check_online,
                                      "location": location,
                                      "gender": param_gender,
                                      "max_distance": param_max_distance,
                                      "age_range": param_age
        ]
 
        api.request(endpoint, method: HTTPMethod.get, parameters: parameters, encoding: URLEncoding.queryString)
            .responseSwiftyJson { response in
                
                switch response.result {
                case .success(let json):
                    var userList:[User?] = []
                    var error: APIError?
                    if json["error"].int == 0 {
                        let json_users = json["users"]
                        
                        for index in 0 ..< json_users.count - 1 {
                            let user = json_users[index]
                            let jsonData = try! user.rawData()
                            let user_data = try! JSONDecoder().decode(User.self, from: jsonData)
                            userList.append(user_data)
                        }
                        
                    } else {
                        error = APIError(json["error"].intValue, json["error_m"].stringValue)
                    }
                    completion(userList, error)
                case .failure:
                    let error = APIError(404, "Server Connection Failed")
                    completion(nil, error)
                    print("API CALL FAILED")
                }
        }
    }
    
    func meet(uid2: String, uid3: String, completion: @escaping (_ user: [Discover?]?, _ error: APIError?) -> Void) {
           
        let user = Common.userInfo()
        let userId = user.id!
                
        let parameters: Parameters = ["action": "meet",
                                     "uid1": userId,
                                     "uid2": uid2,
                                     "uid3": uid3
        ]
    
       api.request(endpoint, method: HTTPMethod.get, parameters: parameters, encoding: URLEncoding.queryString)
           .responseSwiftyJson { response in
               
            switch response.result {
            case .success(let json):
                var userList:[Discover?] = []
                var error: APIError?
                if json["error"].int == 0 {
                    let json_users = json["result"]
                   
                    if (json_users.count > 0) {
                        for index in 0 ..< json_users.count {
                            let user = json_users[index]
                            let jsonData = try! user.rawData()
                            var user_data = try! JSONDecoder().decode(Discover.self, from: jsonData)
                            if let fan = user_data.fan {
                                user_data.liked = fan == 1
                            }
                            userList.append(user_data)
                        }
                    }
               } else {
                   error = APIError(json["error"].intValue, json["error_m"].stringValue)
               }
               completion(userList, error)
            case .failure:
               let error = APIError(404, "Server Connection Failed")
               completion(nil, error)
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
        let parameters: Parameters = ["action": "userProfile",
                                      "id": userId]
        
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
            completion("")
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
    
    func update_location(address: String, lat: String, lng: String, completion: @escaping (_ error: APIError?) -> Void) {
        let user = Common.userInfo()
        let userId = user.id!
        let query = userId + "[sp]" + lat + "[sp]" + lng + "[sp]" + address
        let parameters: Parameters = ["action": "updateLocationA",
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
    
    
    
    func update_radius(radius: String, completion: @escaping (_ error: APIError?) -> Void) {
        let user = Common.userInfo()
        let userId = user.id!
        let query = userId + "," + radius;
        let parameters: Parameters = ["action": "updateSRadius",
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

}
