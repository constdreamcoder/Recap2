//
//  UITableViewCell+Extension.swift
//  CryptoCoin
//
//  Created by SUCHAN CHANG on 2/27/24.
//

import UIKit

extension UITableViewCell: Identifier {
    static var identifier: String {
        return String(describing: self)
    }
}


