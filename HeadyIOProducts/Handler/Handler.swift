//
//  Handler.swift
//  HeadyIOProducts
//
//  Created by MacBook on 5/31/19.
//  Copyright © 2019 DOT. All rights reserved.
//

import Foundation

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

class APIHandler {
    
    func requestDataToAPI(completionHandler: @escaping httpRequestCompletionBlock) {
        ServiceManager().execute(request: URL(string: GETURL.stock.rawValue)!,completionBlock: {(data: Data?, response: Any?, error: NSError?) -> Void in
            completionHandler(data, response, error)
        })
    }
}

import RealmSwift

class DBHandler {
    
    func saveToDB(response: [String: Any]) {
        do {
            let realm = try Realm()
            realm.beginWrite()
            
            if let categories = response["categories"] as? Array<[String: Any]> {
                let allCategory = AllCategory()
                
                for aCategory in categories {
                    let category = Category()
                    
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
                                
                                tax.id = product.id
                            }
                            
                            product.tax = tax
                            realm.add(product)
                            category.products.append(product)
                        }
                    }
                    
                    realm.add(category)
                    allCategory.categories.append(category)
                    realm.add(allCategory)
                }
            }
            
            if let rankings = response["rankings"] as? Array<[String: Any]> {
                let allRank = AllRanks()
                
                for rank in rankings {
                    let aRank = Rankings()
                    
                    if let name = rank["ranking"] as? String {
                        aRank.ranking = name
                    }
                    
                    if let products = rank["products"] as? Array<[String: Any]> {
                        for aProduct in products {
                            
                            if let id = aProduct["id"] as? Int {
                                let allCategory = Array(Array(realm.objects(AllCategory.self))[0].categories)
                                let allProducts = allCategory.flatMap({$0.products})
                                
                                if let rankingProduct = allProducts.filter({$0.id == id}).first {
                                    
                                    if let viewedCount = aProduct["view_count"] as? Int {
                                        rankingProduct.viewedCount = viewedCount
                                    }
                                    
                                    if let orderedCount = aProduct["order_count"] as? Int {
                                        rankingProduct.orderedCount = orderedCount
                                    }
                                    
                                    if let sharedCount = aProduct["shares"] as? Int {
                                        rankingProduct.sharedCount = sharedCount
                                    }
                                    
                                    aRank.products.append(rankingProduct)
                                }
                            }
                        }
                    }
                    
                    realm.add(aRank)
                    allRank.ranks.append(aRank)
                }
                
                realm.add(allRank)
            }
            do {
                try realm.commitWrite()
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: AppConstant.DBSaveNotification), object: nil)

            } catch {
                print(error.localizedDescription)
            }
            
        } catch {
            print(error.localizedDescription)
        }
        

    }
}
