//
//  BaseAPI.swift
//  Hush-SwiftUI
//
//  Created by iOS-dev on 27/05/2020.
//  Copyright © 2020 AppServices. All rights reserved.
//

import Foundation
import Alamofire

class BaseAPI {
    
    internal let deviceUUID: String = UIDevice.current.identifierForVendor!.uuidString
    internal let endpoint: String  = "https://www.hushsite.com/requests/api.php"
    internal let api: SessionManager
    
    init() {
        let configuration = URLSessionConfiguration.default
        api = Alamofire.SessionManager(configuration: configuration)
        api.adapter = AccessTokenAdapter()
    }
}


class AccessTokenAdapter: RequestAdapter {
    func adapt(_ urlRequest: URLRequest) throws -> URLRequest {
        var urlRequest = urlRequest
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        return urlRequest
    }
}
