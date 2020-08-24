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
    
    func message_read(to_user_id: String, completion: @escaping (_ error: APIError?) -> Void) {
        let user = Common.userInfo()
        let userId = user.id!
        let query = userId + "," + to_user_id
        let parameters: Parameters = ["action": "messageRead",
                                      "query": query]
        
        let request = AF.request(endpoint, parameters: parameters)
        request.responseJSON { (response) in
            if let data = response.data {
                do {
                    let json = try JSON(data: data)
                    
                    switch response.result {
                    case .success(_):
                        var error: APIError?
                        if (json["error"].int == 0) {
                            error = nil
                        } else {
                            error = APIError(json["error"].intValue, json["error_m"].stringValue)
                        }
                        completion(error)
                    case .failure:
                        print("API CALL FAILED")
                        completion(nil)
                    }
                } catch {
                    completion(APIError(404, "Server Connection Failed"))
                }
            }
        }
    }
    
    func unread_message_count(completion: @escaping (_ count: Int?, _ error: APIError?) -> Void) {
        let user = Common.userInfo()
        let userId = user.id!
        let parameters: Parameters = ["action": "unreadMessageCount",
                                      "id": userId]
        
        let request = AF.request(endpoint, parameters: parameters)
        request.responseJSON { (response) in
            if let data = response.data {
                do {
                    let json = try JSON(data: data)
                    
                    switch response.result {
                    case .success(_):
                        var error: APIError?
                        var count: Int?
                        if (json["error"].int == 0) {
                            error = nil
                            count = json["unreadMessageCount"].intValue
                        } else {
                            error = APIError(json["error"].intValue, json["error_m"].stringValue)
                        }
                        completion(count, error)
                    case .failure:
                        print("API CALL FAILED")
                        completion(nil, APIError(404, "Server Connection Failed"))

                    }
                } catch {
                    completion(nil, APIError(404, "Server Connection Failed"))
                }
            }
        }
    }
    
    func get_chat(completion: @escaping (_ matches: [ChatMember?]?, _ error: APIError?) -> Void) {
     
         let user = Common.userInfo()
         let userId = user.id!
         let parameters = ["action": "getChat",
                            "id": userId]
     
        let request = AF.request(endpoint, parameters: parameters)
        request.responseJSON { (response) in
            if let data = response.data {
                do {
                    let json = try JSON(data: data)
                    
                    switch response.result {
                    case .success(_):
                        var memberList:[ChatMember?] = []
                        var error: APIError?

                        if (json["error"].int == 0) {

                            let json_matches = json["matches"]

                            if (json_matches.count > 0) {
                                for index in 0 ..< json_matches.count {
                                    let member = json_matches[index]
                                    do {
                                        let jsonData = try member.rawData()
                                        var member_data = try JSONDecoder().decode(ChatMember.self, from: jsonData)
                                        member_data.liked = false
                                        memberList.append(member_data)
                                    } catch {
                                        let error = APIError(404, "Server Connection Failed")
                                        completion(nil, error)
                                        break
                                    }
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
                } catch {
                    completion(nil, APIError(404, "Server Connection Failed"))
                }
            } else {
                completion(nil, APIError(404, "Server Connection Failed"))
            }
        }
    }
    
    func user_chat(to_user_id: String, completion: @escaping (_ matches: [ChatMessage?]?, _ error: APIError?) -> Void) {
     
         let user = Common.userInfo()
         let userId = user.id!
         let parameters = ["action": "userChat",
                            "uid1": userId,
                            "uid2": to_user_id]
     
        let request = AF.request(endpoint, parameters: parameters)
        request.responseJSON { (response) in
            if let data = response.data {
                do {
                    let json = try JSON(data: data)
                    
                    switch response.result {
                    case .success(_):
                        var memberList:[ChatMessage?] = []
                        var error: APIError?

                        if (json["error"].int == 0) {

                            let json_matches = json["chat"]

                            if (json_matches.count > 0) {
                                for index in 0 ..< json_matches.count {
                                    let member = json_matches[index]
                                    do {
                                        let jsonData = try member.rawData()
                                        let member_data = try JSONDecoder().decode(ChatMessage.self, from: jsonData)
                                        memberList.append(member_data)
                                    } catch {
                                        let error = APIError(404, "Server Connection Failed")
                                        completion(nil, error)
                                        break
                                    }
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
                } catch {
                    completion(nil, APIError(404, "Server Connection Failed"))
                }
            } else {
                completion(nil, APIError(404, "Server Connection Failed"))
            }
        }
    }
    
    func sendMessage(to_user_id: String, message: String, type: String, completion: @escaping (_ error: APIError?) -> Void) {
     
        let user = Common.userInfo()
        let userId = user.id!
        let query = userId + "[message]" + to_user_id + "[message]" + message + "[message]" + type
        let parameters = ["action": "sendMessage",
                            "query": query]
     
        let request = AF.request(endpoint, parameters: parameters)
        request.responseJSON { (response) in
            if let data = response.data {
                do {
                    let json = try JSON(data: data)
                    
                    switch response.result {
                    case .success(_):
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
                } catch {
                    completion(APIError(404, "Server Connection Failed"))
                }
            } else {
                completion(APIError(404, "Server Connection Failed"))
            }
        }
    }
}
