//
//  CoinMargetModel.swift
//  CryptoCoin
//
//  Created by SUCHAN CHANG on 3/2/24.
//

import Foundation

struct CoinMargetModel: Decodable {
    let id: String
    let symbol: String
    let name: String
    let image: String
    let current_price: Double
    let price_change_percentage_24h: Double
    let low_24h: Double
    let high_24h: Double
    let ath: Double
    let ath_date: String
    let atl: Double
    let atl_date: String
    let last_updated: String
    let sparkline_in_7d: SparklineIn7D
}

struct SparklineIn7D: Decodable {
    let price: [Double]
}
