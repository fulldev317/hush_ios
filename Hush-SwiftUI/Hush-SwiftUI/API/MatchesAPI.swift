//
//  StoryAPI.swift
//  Hush-SwiftUI
//
//  Created by fulldev on 7/23/20.
//  Copyright © 2020 AppServices. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class MatchesAPI: BaseAPI {
    
    static let shared: MatchesAPI = MatchesAPI()

    func matches(completion: @escaping (_ matches: [Match?]?, _ error: APIError?) -> Void) {
     
         let user = Common.userInfo()
         let userId = user.id!
         let parameters = ["action": "matches",
                            "uid": userId
                            ]
     
        let request = AF.request(endpoint, parameters: parameters)
        request.responseJSON { (response) in
            if let data = response.data {
                let json = try! JSON(data: data)
                
                switch response.result {
                case .success(_):
                    var matchList:[Match?] = []
                    var error: APIError?

                    if (json["error"].int == 0) {

                        let json_matches = json["matches"]

                         if (json_matches.count > 0) {
                             for index in 0 ..< json_matches.count {
                                 let match = json_matches[index]
                                 let jsonData = try! match.rawData()
                                 var match_data = try! JSONDecoder().decode(Match.self, from: jsonData)
                                 match_data.liked = false
                                 matchList.append(match_data)
                             }
                         }
                    } else {
                        error = APIError(json["error"].intValue, json["error_m"].stringValue)
                    }
                    completion(matchList, error)

                case .failure:
                    let error = APIError(404, "Server Connection Failed")
                    completion(nil, error)
                    print("API CALL FAILED")
                }
            }
        }
    }
    
    func visited_me(completion: @escaping (_ matches: [Match?]?, _ error: APIError?) -> Void) {
     
         let user = Common.userInfo()
         let userId = user.id!
         let parameters = ["action": "getVisitors",
                            "uid": userId
                            ]
     
        let request = AF.request(endpoint, parameters: parameters)
        request.responseJSON { (response) in
            if let data = response.data {
                let json = try! JSON(data: data)
                
                switch response.result {
                    case .success(_):
                    var matchList:[Match?] = []
                    var error: APIError?

                    if (json["error"].int == 0) {

                        let json_matches = json["visitors"]

                         if (json_matches.count > 0) {
                             for index in 0 ..< json_matches.count {
                                 let match = json_matches[index]
                                 let jsonData = try! match.rawData()
                                 var match_data = try! JSONDecoder().decode(Match.self, from: jsonData)
                                 match_data.liked = false
                                 matchList.append(match_data)
                             }
                         }
                    } else {
                        error = APIError(json["error"].intValue, json["error_m"].stringValue)
                    }
                    completion(matchList, error)

                case .failure:
                    let error = APIError(404, "Server Connection Failed")
                    completion(nil, error)
                    print("API CALL FAILED")
                }
            }
        }
    }
    
    func likes_me(completion: @escaping (_ matches: [Match?]?, _ error: APIError?) -> Void) {
     
         let user = Common.userInfo()
         let userId = user.id!
         let parameters = ["action": "likesMe",
                            "uid": userId
                            ]
     
        let request = AF.request(endpoint, parameters: parameters)
        request.responseJSON { (response) in
            if let data = response.data {
                let json = try! JSON(data: data)
                
                switch response.result {
                case .success(_):
                    var matchList:[Match?] = []
                    var error: APIError?

                    if (json["error"].int == 0) {

                        let json_matches = json["likesMe"]

                         if (json_matches.count > 0) {
                             for index in 0 ..< json_matches.count {
                                 let match = json_matches[index]
                                 let jsonData = try! match.rawData()
                                 var match_data = try! JSONDecoder().decode(Match.self, from: jsonData)
                                 match_data.liked = false
                                 matchList.append(match_data)
                             }
                         }
                    } else {
                        error = APIError(json["error"].intValue, json["error_m"].stringValue)
                    }
                    completion(matchList, error)

                case .failure:
                    let error = APIError(404, "Server Connection Failed")
                    completion(nil, error)
                    print("API CALL FAILED")
                }
            }
        }
    }
    
    func my_likes(completion: @escaping (_ matches: [Match?]?, _ error: APIError?) -> Void) {
     
         let user = Common.userInfo()
         let userId = user.id!
         let parameters = ["action": "myLikes",
                            "uid": userId
                            ]
     
        let request = AF.request(endpoint, parameters: parameters)
        request.responseJSON { (response) in
            if let data = response.data {
                let json = try! JSON(data: data)
                
                switch response.result {
                case .success(_):
                    var matchList:[Match?] = []
                    var error: APIError?

                    if (json["error"].int == 0) {
                        
                        let json_matches = json["myLikes"]
                        
                         if (json_matches.count > 0) {
                             for index in 0 ..< json_matches.count {
                                 let match = json_matches[index]
                                 let jsonData = try! match.rawData()
                                 var match_data = try! JSONDecoder().decode(Match.self, from: jsonData)
                                 match_data.liked = true
                                 matchList.append(match_data)
                             }
                         }
                    } else {
                        error = APIError(json["error"].intValue, json["error_m"].stringValue)
                    }
                    completion(matchList, error)

                case .failure:
                    let error = APIError(404, "Server Connection Failed")
                    completion(nil, error)
                    print("API CALL FAILED")
                }
            }
        }
    }
    
}
