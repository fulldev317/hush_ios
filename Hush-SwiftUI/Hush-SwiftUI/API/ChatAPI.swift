//
//  ChatAPI.swift
//  Hush-SwiftUI
//
//  Created by iOS-dev on 27/05/2020.
//  Copyright © 2020 AppServices. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class ChatAPI: BaseAPI {
    
    static let shared: ChatAPI = ChatAPI()
    
    func messageRead(completion: @escaping () -> Void) {
        let userId: String = "user_id"
        let parameters: Parameters = ["action": "getChat",
                                      "id": userId]
        
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
    
    func getChat(completion: @escaping (_ matches: [ChatMember?]?, _ error: APIError?) -> Void) {
     
         let user = Common.userInfo()
         let userId = user.id!
         let parameters = ["action": "getChat",
                            "id": userId]
     
        Alamofire.request(endpoint, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: nil) .responseSwiftyJson { response in
                    
            switch response.result {
            case .success(let json):
                var memberList:[ChatMember?] = []
                var error: APIError?

                if (json["error"].int == 0) {
                    
                    let json_matches = json["matches"]
                    
                     if (json_matches.count > 0) {
                         for index in 0 ..< json_matches.count {
                             let member = json_matches[index]
                             let jsonData = try! member.rawData()
                             var member_data = try! JSONDecoder().decode(ChatMember.self, from: jsonData)
                             member_data.liked = false
                             memberList.append(member_data)
                         }
                     }
                } else {
                    error = APIError(json["error"].intValue, json["error_m"].stringValue)
                }
                completion(memberList, error)

            case .failure:
                let error = APIError(404, "Server Connection Failed")
                completion(nil, error)
                print("API CALL FAILED")
            }
        }
    }
    
    func userChat(to_user_id: String, completion: @escaping (_ matches: [ChatMessage?]?, _ error: APIError?) -> Void) {
     
         let user = Common.userInfo()
         let userId = user.id!
         let parameters = ["action": "userChat",
                            "uid1": userId,
                            "uid2": to_user_id]
     
        Alamofire.request(endpoint, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: nil) .responseSwiftyJson { response in
                    
            switch response.result {
            case .success(let json):
                var memberList:[ChatMessage?] = []
                var error: APIError?

                if (json["error"].int == 0) {
                    
                    let json_matches = json["chat"]
                    
                    if (json_matches.count > 0) {
                        for index in 0 ..< json_matches.count {
                            let member = json_matches[index]
                            let jsonData = try! member.rawData()
                            let member_data = try! JSONDecoder().decode(ChatMessage.self, from: jsonData)
                            memberList.append(member_data)
                        }
                    }
                } else {
                    error = APIError(json["error"].intValue, json["error_m"].stringValue)
                }
                completion(memberList, error)

            case .failure:
                let error = APIError(404, "Server Connection Failed")
                completion(nil, error)
                print("API CALL FAILED")
            }
        }
    }
    
    func sendMessage(to_user_id: String, message: String, type: String, completion: @escaping (_ error: APIError?) -> Void) {
     
         let user = Common.userInfo()
         let userId = user.id!
        let query = userId + "[message]" + to_user_id + "[message]" + message + "[message]" + type
         let parameters = ["action": "sendMessage",
                            "query": query]
     
        Alamofire.request(endpoint, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: nil) .responseSwiftyJson { response in
                    
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
                let error = APIError(404, "Server Connection Failed")
                completion(error)
                print("API CALL FAILED")
            }
        }
    }
}
