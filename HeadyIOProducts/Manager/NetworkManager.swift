//
//  NetworkManager.swift
//  HeadyIOProducts
//
//  Created by MacBook on 5/27/19.
//  Copyright © 2019 DOT. All rights reserved.
//

import Foundation

public typealias parseCompletionHandler = ([String: Any]) -> Void

class ParseHandler {
    func parse(data: Data, completionHandler: @escaping parseCompletionHandler) {
        do {
            if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                completionHandler(json)
            }
        } catch let error as NSError {
            print("Failed to load: \(error.localizedDescription)")
        }
    }
}

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
                ParseHandler().parse(data: aData, completionHandler: { (json) in
                    DBHandler().saveToDB(response: json)
                })
            }
        }
    }
}

