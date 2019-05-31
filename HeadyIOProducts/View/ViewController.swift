//
//  ViewController.swift
//  HeadyIOProducts
//
//  Created by MacBook on 5/27/19.
//  Copyright © 2019 DOT. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        let manager = NetworkManager(apiHandler: APIHandler(),
                                     parseHandler: ParseHandler(),
                                     dbHandler: DBHandler())
        manager.handle()
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.savedSucess),
                                               name: NSNotification.Name(rawValue: AppConstant.DBSaveNotification),
                                               object: nil)

    }
 
    @ objc func savedSucess(info: NSNotification) {
        NotificationCenter.default.removeObserver(self,
                                                  name: NSNotification.Name(rawValue: AppConstant.DBSaveNotification),
                                                  object: nil)
        
        /*
        let allCategoryProducts: AllProducts = AllProductsFromCategory()
        let allProductsBasedOnCategory: AllProducts = ProductBasedOnCategory(with: 1)
        let allProductBasedOnRank: AllProducts = ProductsBasedOnRank(with: 2)
        let aProduct: AProduct = ProductBasedOnID(with: 3)
        
s        print(allCategoryProducts.products)
        print(allProductsBasedOnCategory.products)
        print(allProductBasedOnRank.products)
        print(aProduct.product)
         */
    }
}
