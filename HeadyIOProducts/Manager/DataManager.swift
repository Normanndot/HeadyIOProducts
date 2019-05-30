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

                    if let categories = value as? Array<[String: Any]> {
                        for aCategory in categories {
                            let category = Category()
                            realm.beginWrite()
                            
                            if let id = aCategory["id"] as? Int {
                                category.id = id
                            }

                            if let name = aCategory["name"] as? String {
                                category.name = name
                            }

                            if let products = aCategory["products"] as? Array<[String: Any]> {
                                for aProduct in products {
                                    let product = Product()

                                    if let id = aProduct["id"] as? Int {
                                        product.id = id
                                    }
                                    
                                    if let name = aProduct["name"] as? String {
                                        product.name = name
                                    }

                                    if let date = aProduct["date_added"] as? String {
                                        product.dateAdded = date.toDate()
                                    }
                                    
                                    if let variants = aProduct["variants"] as? Array<[String: Any]> {
                                        for aVariant in variants {
                                            let variant = Variant()

                                            if let id = aVariant["id"] as? Int {
                                                variant.id = id
                                            }
                                            
                                            if let color = aVariant["color"] as? String {
                                                variant.color = color
                                            }

                                            if let size = aVariant["size"] as? Int {
                                                variant.size = size
                                            }
                                            
                                            if let price = aVariant["price"] as? Int {
                                                variant.price = price
                                            }
                                            
                                            product.variants.append(variant)
                                            realm.add(variant)
                                        }
                                    }
                                    
                                    let tax = Tax()
                                    if let aTax = aProduct["tax"] as? [String: Any] {
                                        if let name = aTax["name"] as? String {
                                            tax.name = name
                                        }
                                        
                                        if let value = aTax["value"] as? Float {
                                            tax.value = value
                                        }
                                    }
                                    
                                    product.tax = tax
                                    realm.add(product)
                                    category.products.append(product)
                                }
                            }

                            realm.add(category)

                            do {
                                try realm.commitWrite()
                                
                                print(Realm.Configuration.defaultConfiguration.fileURL)
                            } catch {
                               print(error.localizedDescription)
                            }
                        }
                    }
                } catch {
                    print(error.localizedDescription)
                }
            }
            
            if key == "rankings" {
                
            }
        }
        
    }
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
    @objc dynamic var count: Int = 0
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
    
    override static func primaryKey() -> String? {
        return "id"
    }
}

class Tax: Object {
    @objc dynamic var name: String? = nil
    @objc dynamic var value: Float = 0.0
}

class Rankings: Object {
    @objc dynamic var ranking: String? = nil
    let products = List<Product>()
}
