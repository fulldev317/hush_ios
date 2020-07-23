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

class StoryAPI: BaseAPI {
    
    static let shared: StoryAPI = StoryAPI()

    func upload_story(image_path: String, image_thumb: String, completion: @escaping (_ story: Stories?) -> Void) {

        let user = Common.userInfo()
        let userId = user.id!
        let parameters = ["action": "uploadStory",
                                      "uid": userId,
                                      "media[0][status]": "ok",
                                      "media[0][video]": "0",
                                      "media[0][path]": image_path,
                                      "media[0][thumb]": image_thumb]

        Alamofire.request(storyendpoint, method: .post, parameters: parameters, encoding: URLEncoding.default, headers: nil) .responseSwiftyJson { response in
                       
            switch response.result {
            case .success(let json):
                let stories: Stories?
                let jsonData = try! json.rawData()
                stories = try! JSONDecoder().decode(Stories.self, from: jsonData)
                completion(stories)
            case .failure:
               completion(nil)
               print("API CALL FAILED")
            }
        }
    }
        
    func view_story(completion: @escaping (_ story: Stories?) -> Void) {
     
         let user = Common.userInfo()
         let userId = user.id!
         let parameters = ["action": "viewStory",
                            "uid": userId
                            ]
     
        Alamofire.request(storyendpoint, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: nil) .responseSwiftyJson { response in
                    
            switch response.result {
            case .success(let json):
                if (json["error"].int == 0) {
                     let stories: Stories?
                     let jsonData = try! json.rawData()
                     stories = try! JSONDecoder().decode(Stories.self, from: jsonData)
                        
                     completion(stories)
                }
                completion(nil)
            case .failure:
                completion(nil)
                print("API CALL FAILED")
            }
        }
    }
}
