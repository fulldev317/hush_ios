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

    func upload_story(image_path: String, image_thumb: String, completion: @escaping (_ story: [Story?]?, _ error: APIError?) -> Void) {

        let user = Common.userInfo()
        let userId = user.id!
        let parameters = ["action": "uploadStory",
                                      "uid": userId,
                                      "media[0][status]": "ok",
                                      "media[0][video]": "0",
                                      "media[0][path]": image_path,
                                      "media[0][thumb]": image_thumb]

        let request = AF.request(belloo_endpoint, method: .post, parameters: parameters)
        request.responseJSON { (response) in
            if let data = response.data {
                let json = try! JSON(data: data)
                
                switch response.result {
                case .success(_):
                    var error: APIError?
                    var storyList: [Story?] = []

                    if (json["story"].intValue > 0) {
                        let json_stories = json["stories"]

                        if (json_stories.count > 0) {
                            for index in 0 ..< json_stories.count {
                                let story = json_stories[index]
                                let jsonData = try! story.rawData()
                                var story_data = try! JSONDecoder().decode(Story.self, from: jsonData)
                                story_data.liked = false
                                storyList.append(story_data)
                            }
                        }
                    } else {
                        error = APIError(json["error"].intValue, json["error_m"].stringValue)
                    }
                    completion(storyList, error)
                case .failure:
                   let error = APIError(404, "Server Connection Failed")
                   completion(nil, error)
                   print("API CALL FAILED")
                }
            } else {
                let error = APIError(404, "Server Connection Failed")
                completion(nil, error)
            }
        }
    }
        
    func view_story(userId: String, completion: @escaping (_ stories: [Story?]?, _ error: APIError?) -> Void) {
     
         let parameters = ["action": "viewStory",
                            "uid": userId]
     
        let request = AF.request(endpoint, parameters: parameters)
        request.responseJSON { (response) in
            if let data = response.data {
                let json = try! JSON(data: data)
                
                switch response.result {
                case .success(_):
                    var error: APIError?
                    var storyList: [Story?] = []
                    if (json["error"].int == 0) {
                        let json_stories = json["stories"]

                        if (json_stories.count > 0) {
                            for index in 0 ..< json_stories.count {
                                let story = json_stories[json_stories.count - index - 1]
                                let jsonData = try! story.rawData()
                                do {
                                    var story_data = try JSONDecoder().decode(Story.self, from: jsonData)
                                    story_data.liked = false
                                    if let review: String = story_data.review {
                                        if review.lowercased() != "yes" {
                                            storyList.append(story_data)
                                        }
                                    }
                                } catch {
                                    let error = APIError(json["error"].intValue, json["error_m"].stringValue)
                                    completion( nil, error)
                                    return
                                }
                            }
                        }
                    } else {
                        error = APIError(json["error"].intValue, json["error_m"].stringValue)
                    }

                    completion(storyList, error)
                case .failure:
                    let error = APIError(404, "Server Connection Failed")
                    completion(nil, error)
                    print("API CALL FAILED")
                }
            } else {
                let error = APIError(404, "Server Connection Failed")
                completion(nil, error)
            }
        }
    }
    
    func view_stories(completion: @escaping (_ stories: [Stories?]?, _ error: APIError?) -> Void) {
     
         let user = Common.userInfo()
         let userId = user.id!
         let parameters = ["action": "viewStories",
                            "uid": userId
                            ]
     
        let request = AF.request(endpoint, parameters: parameters)
        request.responseJSON { (response) in
            if let data = response.data {
                let json = try! JSON(data: data)
                
                switch response.result {
                case .success(_):
                    var error: APIError?
                    var storyList: [Stories?] = []
                    if (json["error"].int == 0) {
                        let json_stories = json["stories"]

                        if (json_stories.count > 0) {
                            for index in 0 ..< json_stories.count {
                                let story = json_stories[index]
                                let jsonData = try! story.rawData()
                                do {
                                    var story_data = try JSONDecoder().decode(Stories.self, from: jsonData)
                                    story_data.liked = false
                                    storyList.append(story_data)
                                } catch {
                                    let error = APIError(json["error"].intValue, json["error_m"].stringValue)
                                    completion( nil, error)
                                    return
                                }
                            }
                        }
                    } else {
                        error = APIError(json["error"].intValue, json["error_m"].stringValue)
                    }

                    completion(storyList, error)
                case .failure:
                    let error = APIError(404, "Server Connection Failed")
                    completion(nil, error)
                    print("API CALL FAILED")
                }
            } else {
                let error = APIError(404, "Server Connection Failed")
                completion(nil, error)
            }
        }
    }
    
    func delete_story(storyId: String, completion: @escaping (_ error: APIError?) -> Void) {
     
         let parameters = ["action": "deleteStory",
                            "sid": storyId]
     
        let request = AF.request(endpoint, parameters: parameters)
        request.responseJSON { (response) in
            if let data = response.data {
                let json = try! JSON(data: data)
                
                switch response.result {
                case .success(_):
                    var error: APIError?
                    if (json["error"].int == 0) {
                        error = nil
                    } else {
                        error = APIError(json["error"].intValue, json["error_m"].stringValue)
                    }
                    completion( error)
                case .failure:
                    let error = APIError(404, "Server Connection Failed")
                    completion(error)
                    print("API CALL FAILED")
                }
            } else {
                let error = APIError(404, "Server Connection Failed")
                completion(error)
            }
        }
    }
    
    func make_primary_image(storyId: String, completion: @escaping (_ error: APIError?) -> Void) {
     
        let parameters = ["action": "makePrimaryImage",
                            "sid": storyId]
     
        let request = AF.request(endpoint, parameters: parameters)
        request.responseJSON { (response) in
            if let data = response.data {
                let json = try! JSON(data: data)
                
                switch response.result {
                case .success(_):
                    var error: APIError?
                    if (json["error"].int == 0) {
                        error = nil
                    } else {
                        error = APIError(json["error"].intValue, json["error_m"].stringValue)
                    }
                    completion( error)
                case .failure:
                    let error = APIError(404, "Server Connection Failed")
                    completion(error)
                    print("API CALL FAILED")
                }
            } else {
                let error = APIError(404, "Server Connection Failed")
                completion(error)
            }
        }
    }
}
