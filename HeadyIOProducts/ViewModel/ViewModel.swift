//
//  ViewModel.swift
//  HeadyIOProducts
//
//  Created by MacBook on 5/30/19.
//  Copyright © 2019 DOT. All rights reserved.
//

import Foundation
import RealmSwift

protocol RankingsViewModel {
    var rankings: [Rankings] { get }
}

protocol AllCategoryList {
    var categories: [Category] { get }
}

protocol AllProducts {
    var products: [Product] { get }
}

protocol AProduct {
    var product: Product { get }
}

class AllProductsFromCategory: AllProducts {
    var products: [Product]

    init() {
        let realm = try! Realm()
        let allCategory = Array(realm.objects(AllCategory.self))
        let categoryList = Array(allCategory[0].categories)
        self.products = categoryList.flatMap({$0.products})
    }
}

class AllProductsFromRankings: AllProducts {
    var products: [Product]
    
    init(with rankIndex: Int) {
        let realm = try! Realm()
        let allRankings = Array(realm.objects(Rankings.self))
        let aRankingProducts = Array(allRankings[rankIndex].products)
        self.products = aRankingProducts.compactMap({$0})
    }
}

class RankingViewModelForProduct: NSObject, RankingsViewModel {
    var rankings: [Rankings]
    
    override init() {
        let realm = try! Realm()
        self.rankings = Array(realm.objects(Rankings.self))
        super.init()
    }
}

class ProductsBasedOnRank: NSObject, AllProducts {
    var products: [Product]

    init(with rankIndex: Int) {
        let rankingProducts = AllProductsFromRankings.init(with: rankIndex).products
        let categoryProducts = AllProductsFromCategory.init().products
        self.products = zip(categoryProducts, rankingProducts).filter() {
            $1.id == $1.id
            }.map{$0.0}
        super.init()
    }
}

class ProductBasedOnCategory: NSObject, AllProducts {
    var products: [Product]
    
    init(with id: Int) {
        let realm = try! Realm()
        let allCategory = realm.objects(AllCategory.self)[0]
        self.products = Array(Array(allCategory.categories).filter({$0.id == id})[0].products)
        super.init()
    }
}

class ProductBasedOnID: AProduct {
    var product: Product
    
    init(with id: Int) {
        let categoryProducts = AllProductsFromCategory.init().products
        product = categoryProducts.filter({$0.id == id})[0]
    }
}
