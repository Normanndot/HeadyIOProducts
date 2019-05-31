//
//  ManagedObjectModel.swift
//  HeadyIOProducts
//
//  Created by MacBook on 5/31/19.
//  Copyright © 2019 DOT. All rights reserved.
//

import Foundation
import RealmSwift

class AllCategory: Object {
    let categories = List<Category>()
}

class Category: Object {
    @objc dynamic var id: Int = 0
    @objc dynamic var name: String? = nil
    let products = List<Product>()
    let childCategories = List<Int>()
    
    override static func primaryKey() -> String? {
        return "id"
    }
}

class Product: Object {
    @objc dynamic var id: Int = 0
    @objc dynamic var name: String? = nil
    @objc dynamic var dateAdded: Date?
    let variants = List<Variant>()
    @objc dynamic var viewedCount: Int = 0
    @objc dynamic var sharedCount: Int = 0
    @objc dynamic var orderedCount: Int = 0
    @objc dynamic var tax: Tax?
    
    override static func primaryKey() -> String? {
        return "id"
    }
}

class Variant: Object {
    @objc dynamic var id: Int = 0
    @objc dynamic var color: String? = nil
    @objc dynamic var size: Int = 0
    @objc dynamic var price: Int = 0
}

class Tax: Object {
    @objc dynamic var id: Int = 0
    @objc dynamic var name: String? = nil
    @objc dynamic var value: Float = 0.0
    
    override static func primaryKey() -> String? {
        return "id"
    }
}

class AllRanks: Object {
    let ranks = List<Rankings>()
}

class Rankings: Object {
    @objc dynamic var ranking: String? = nil
    let products = List<Product>()
}
