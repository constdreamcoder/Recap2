//
//  TrendingModel.swift
//  CryptoCoin
//
//  Created by SUCHAN CHANG on 3/3/24.
//

import Foundation

struct TrendingModel: Decodable {
    let coins: [TMCoin]
    let nfts: [TMNFT]
}

struct TMCoin: Decodable {
    let item: TMItem
}

struct TMItem: Decodable {
    let id: String
    let name: String
    let symbol: String
    let small: String
    let market_cap_rank: Int
    let data: TMData
}

struct TMData: Decodable {
    let price: String
    let price_change_percentage_24h: TMPriceChangePercentage24h
}

struct TMPriceChangePercentage24h: Decodable {
    let krw: Double
}

struct TMNFT: Decodable {
    let id: String
    let name: String
    let symbol: String
    let thumb: String
    let data: MTNFTData
}

struct MTNFTData: Decodable {
    let floor_price: String
    let floor_price_in_usd_24h_percentage_change: String
}
