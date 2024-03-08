//
//  String+Extension.swift
//  CryptoCoin
//
//  Created by SUCHAN CHANG on 3/2/24.
//

import Foundation

extension String {
    var convertStringToDate: Date? {
        let dateFormatter = DateFormatter()
        return dateFormatter.date(from: self)
    }
    
    var convertToLastUpdatedFormat: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        
        guard let date = dateFormatter.date(from: self) else { return "" }
        
        dateFormatter.dateFormat = "d/M HH:mm:ss"
        return dateFormatter.string(from: date)
    }
    
    var doSomething: String {
        let numberFormatter = NumberFormatter()
        numberFormatter.maximumFractionDigits = 2
        return numberFormatter.string(from: Double(self)! as NSNumber) ?? "0.00"
    }
}
