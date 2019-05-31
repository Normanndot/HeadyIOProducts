//
//  Utilities.swift
//  HeadyIOProducts
//
//  Created by MacBook on 5/31/19.
//  Copyright © 2019 DOT. All rights reserved.
//

import Foundation

extension String {
    func toDate(withFormat format: String = AppConstant.DataFormat)-> Date?{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        dateFormatter.locale = Locale(identifier: AppConstant.LocaleIdentifier)
        let date = dateFormatter.date(from: self)
        return date
    }
}

class AppConstant {
    static let DataFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
    static let LocaleIdentifier = "en_US_POSIX"
    static let DBSaveNotification = "DBSaveNotification"
}
