//
//  DataManager.swift
//  HeadyIOProducts
//
//  Created by MacBook on 5/27/19.
//  Copyright © 2019 DOT. All rights reserved.
//

import Foundation
import RealmSwift

class DBHandler {
    
    func saveToDB(response: [String: Any]) {
        
        for (key, value) in response {
            if key == "categories" {
                do {
                    let realm = try Realm()
                    realm.beginWrite()
                    
                    let categories = Categories()
                } catch {
                    print(error.localizedDescription)
                }
            }
            
            if key == "rankings" {
                
            }
        }
        
    }
}

class Categories: Object {
    @objc dynamic var id: Int = 0
    @objc dynamic var name: String?
    @objc dynamic var products: [Product]?
    @objc dynamic var childCategories: [Int]?
    
    override static func primaryKey() -> String? {
        return "id"
    }
}

class Product: Object {
    @objc dynamic var id: Int = 0
    @objc dynamic var name: String?
    @objc dynamic var dateAdded: Date?
    @objc dynamic var variants: [Variant]?
    @objc dynamic var tax: Tax?
    @objc dynamic var count: Int = 0
    
    override static func primaryKey() -> String? {
        return "id"
    }
}

class Variant: Object {
    @objc dynamic var id: Int = 0
    @objc dynamic var color: String?
    @objc dynamic var size: Int = 0
    @objc dynamic var price: String?
    
    override static func primaryKey() -> String? {
        return "id"
    }
}

class Tax: Object {
    @objc dynamic var name: String?
    @objc dynamic var value: String?
}

class Rankings: Object {
    @objc dynamic var ranking: String?
    @objc dynamic var products: [Product]?
}
