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
    }
}

