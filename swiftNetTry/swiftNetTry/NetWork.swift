//
//  NetWork.swift
//  swiftNetTry
//
//  Created by nhl on 2017/9/26.
//  Copyright © 2017年 nhl. All rights reserved.
//

import Foundation
class NetWork: AFHTTPSessionManager {
    enum HTTPRequestMethod {
        case GET
        case POST
    }
    static let shared:NetWork = {
        let manager = NetWork()
        manager.responseSerializer.acceptableContentTypes?.insert("text/html")
         manager.responseSerializer.acceptableContentTypes?.insert("text/plain")
        return manager
    }()
    
    func request(requestType: HTTPRequestMethod, urlString: String, parameters: [String: AnyObject]?, completion: @escaping (AnyObject?) -> ()) {
        
        //成功回调
        let success = { (task: URLSessionDataTask, json: Any)->() in
            completion(json as AnyObject?)
        }
        
        //失败回调
        let failure = { (task: URLSessionDataTask?, error: Error) -> () in
            print("网络请求错误 \(error)")
            completion(nil)
        }
        
        if requestType == .GET {
            get(urlString, parameters: parameters, progress: nil, success: success, failure: failure)
        } else {
            post(urlString, parameters: parameters, progress: nil, success: success, failure: failure)
        }
       
    }
}


