//
//  Int+Extension.swift
//  CryptoCoin
//
//  Created by SUCHAN CHANG on 3/2/24.
//

import Foundation

extension Int {
    var convertToKRWCurrency: String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .currency
        return numberFormatter.string(from: self as NSNumber) ?? "₩0"
    }
}
