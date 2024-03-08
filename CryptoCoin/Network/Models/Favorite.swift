//
//  Favorite.swift
//  CryptoCoin
//
//  Created by SUCHAN CHANG on 3/3/24.
//

import Foundation
import RealmSwift

final class Favorite: Object {
    @Persisted(primaryKey: true) var id: String
    @Persisted var name: String
    @Persisted var symbol: String
    @Persisted var imageURLString: String
    
    convenience init(id: String, name: String, symbol: String, imageURLString: String) {
        self.init()
        
        self.id = id
        self.name = name
        self.symbol = symbol
        self.imageURLString = imageURLString
    }
}
