//
//  DateFormatter.swift
//  openNewsProject
//
//  Created by Developer on 03.08.2022.
//

import Foundation


extension DateFormatter {
    static let dateFormatterGet: DateFormatter = {
        let dateFormatterGet: DateFormatter = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd"
        return dateFormatterGet
    }()
    
    static let dateFormatterPrint: DateFormatter = {
        let dateFormatterPrint: DateFormatter = DateFormatter()
        dateFormatterPrint.dateFormat = "d MMMM, yyyy"
        return dateFormatterPrint
    }()
}
