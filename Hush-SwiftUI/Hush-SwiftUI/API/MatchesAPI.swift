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

    func my_likes(completion: @escaping (_ matches: [Match?]?, _ error: APIError?) -> Void) {
     
         let user = Common.userInfo()
         let userId = user.id!
         let parameters = ["action": "myLikes",
                            "uid": userId
                            ]
     
        Alamofire.request(endpoint, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: nil) .responseSwiftyJson { response in
                    
            switch response.result {
            case .success(let json):
                var matchList:[Match?] = []
                var error: APIError?

                if (json["error"].int == 0) {
                    
                    let json_matches = json["mylikes"]
                    
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
    
    func like_me(completion: @escaping (_ matches: Matches?) -> Void) {
     
         let user = Common.userInfo()
         let userId = user.id!
         let parameters = ["action": "likesMe",
                            "uid": userId
                            ]
     
        Alamofire.request(endpoint, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: nil) .responseSwiftyJson { response in
                    
            switch response.result {
            case .success(let json):
                if (json["error"].int == 0) {
                     let matches: Matches?
                     let jsonData = try! json.rawData()
                     matches = try! JSONDecoder().decode(Matches.self, from: jsonData)
                        
                     completion(matches)
                }
                completion(nil)
            case .failure:
                completion(nil)
                print("API CALL FAILED")
            }
        }
    }
}
