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
        print(ProductsBasedOnRank.init(with: 0).products.count)
        NotificationCenter.default.removeObserver(self,
                                                  name: NSNotification.Name(rawValue: AppConstant.DBSaveNotification),
                                                  object: nil)
    }
}
