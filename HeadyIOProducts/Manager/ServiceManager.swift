//
//  ServiceManager.swift
//  HeadyIOProducts
//
//  Created by MacBook on 5/27/19.
//  Copyright © 2019 DOT. All rights reserved.
//

import Foundation

enum GETURL: String {
    case stock = "https://stark-spire-93433.herokuapp.com/json"
}

public typealias httpRequestCompletionBlock = (_ data: Data?, _ response: Any?, _ error: NSError?) -> Void

class APIHandler {
    
    func requestDataToAPI(completionHandler: @escaping httpRequestCompletionBlock) {
        ServiceManager().execute(request: URL(string: GETURL.stock.rawValue)!,completionBlock: {(data: Data?, response: Any?, error: NSError?) -> Void in
                completionHandler(data, response, error)
        })
    }
}

class ServiceManager {

    func execute(request : URL, completionBlock: @escaping httpRequestCompletionBlock) {
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            completionBlock(data, response, error as NSError?)
        }
        
        task.resume()
    }
}
