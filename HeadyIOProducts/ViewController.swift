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

extension String {
    
    func toDate(withFormat format: String = "yyyy-MM-dd'T'HH:mm:ss.SSSZ")-> Date?{
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        let date = dateFormatter.date(from: self)
        
        return date
        
    }
}
