//
//  NetworkManager.swift
//  HeadyIOProducts
//
//  Created by MacBook on 5/27/19.
//  Copyright © 2019 DOT. All rights reserved.
//

import Foundation

public typealias parseCompletionHandler = ([String: Any]) -> Void

class NetworkManager {
    
    let apiHandler: APIHandler
    let parseHandler: ParseHandler
    let dbHandler: DBHandler
    
    init(apiHandler: APIHandler, parseHandler: ParseHandler, dbHandler: DBHandler) {
        self.apiHandler = apiHandler
        self.parseHandler = parseHandler
        self.dbHandler = dbHandler
    }
    
    func handle() {
        apiHandler.requestDataToAPI { (data, response, error) in
            if let aData = data {
                self.parseHandler.parse(data: aData, completionHandler: { (json) in
                    self.dbHandler.saveToDB(response: json)
                })
            }
        }
    }
}

