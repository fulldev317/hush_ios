//
//  BaseAPI.swift
//  Hush-SwiftUI
//
//  Created by iOS-dev on 27/05/2020.
//  Copyright © 2020 AppServices. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class BaseAPI {
    
    internal let deviceUUID: String = UIDevice.current.identifierForVendor!.uuidString
    //internal let endpoint: String  = "https://www.hushdating.app/requests/api.php"
    internal let endpoint: String  = "https://www.hushdating.app/requests/appapi.php"//"https://www.hushsite.com/requests/api.php"
    internal let uploadpoint: String  = "https://www.hushdating.app/assets/sources/upload.php"//"https://www.hushsite.com/assets/sources/upload.php"
    internal let google_place: String  = "https://maps.googleapis.com/maps/api/place/autocomplete/json"
    internal let google_geocode: String  = "https://maps.googleapis.com/maps/api/geocode/json"
    
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

extension DataRequest {
    
    @discardableResult
    public func responseSwiftyJson(completionHandler: @escaping (DataResponse<JSON>) -> Void) -> Self {
        return response(queue: nil,
                        responseSerializer: DataRequest.swiftyResponseSerializer(),
                        completionHandler: completionHandler)
    }
    
    public static func swiftyResponseSerializer() -> DataResponseSerializer<JSON> {
        return DataResponseSerializer { (request, response, data, error) in
            
            if let request = request, let httpBody = request.httpBody {
                debugPrint(String(data: httpBody, encoding: .utf8) as Any)
            }
            debugPrint(response as Any)
            
            let result = Request.serializeResponseJSON(options: .allowFragments, response: response, data: data, error: error)
            
            switch result {
            case .success(let value):
                let jsonObject = JSON(value)
                return .success(jsonObject)
            case .failure(let error):
                return .failure(error)
            }
        }
    }
}
