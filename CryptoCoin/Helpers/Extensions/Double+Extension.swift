//
//  Double+Extension.swift
//  CryptoCoin
//
//  Created by SUCHAN CHANG on 3/2/24.
//

import Foundation

extension Double {
    var moveDecimalPointUtilTwoDecimalPlaces: String {
        let numberFormatter = NumberFormatter()
        numberFormatter.maximumFractionDigits = 2
        return numberFormatter.string(from: self as NSNumber) ?? "0.00"
    }
    
    var convertToKRWCurrency: String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .currency
        return numberFormatter.string(from: self as NSNumber) ?? "₩0.0"
    }
}
