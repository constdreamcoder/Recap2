//
//  SearchModel.swift
//  CryptoCoin
//
//  Created by SUCHAN CHANG on 3/1/24.
//

import Foundation

struct SearchModel: Decodable {
    let coins: [SMCoin]
}

struct SMCoin: Decodable {
    let id: String
    let name: String
    let symbol: String
    let thumb: String
    let large: String
}
