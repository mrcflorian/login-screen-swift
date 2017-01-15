//
//  NetworkingManager.swift
//  LoginScreen
//
//  Created by Florian Marcu on 1/15/17.
//  Copyright © 2017 iOS App Templates. All rights reserved.
//

import AFNetworking

enum ResponseStatus {
    case success
    case error(error: String)
}

class NetworkingManager {

    func get(path: String, params: [String:String]?, completion: ((_ jsonResponse: Any?, _ responseStatus: ResponseStatus) -> Void)?) {
        let manager = AFHTTPSessionManager(baseURL: nil)
        manager.requestSerializer = AFJSONRequestSerializer()
        manager.responseSerializer = AFJSONResponseSerializer()

        manager.get(path, parameters: params, progress: nil, success: { (dataTask, response) in
            if completion != nil {
                completion!(response, .success)
            }
        }) { (dataTask, error) in
            if completion != nil {
                completion!("", .error(error: error.localizedDescription))
            }
        }
    }
}
