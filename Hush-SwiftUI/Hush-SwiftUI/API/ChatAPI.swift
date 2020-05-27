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
    
    func messageRead() {
        let userId: String = "user_id"
        let parameters: Parameters = ["action": "getChat",
                                      "id": userId]
        
        api.request(endpoint, method: HTTPMethod.get, parameters: parameters, encoding: JSONEncoding.default)
            .validate(contentType: ["application/json"])
            .responseJSON { response in
                switch response.result {
                case .success:
                    //TODO
                    break
                case .failure:
                    //TODO
                    break
                }
        }
    }
}
