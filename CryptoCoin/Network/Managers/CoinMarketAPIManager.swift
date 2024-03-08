//
//  CoinMarketAPIManager.swift
//  CryptoCoin
//
//  Created by SUCHAN CHANG on 3/2/24.
//

import Foundation
import Alamofire

final class CoinMarketAPIManager {
    static let shared = CoinMarketAPIManager()
    
    private let baseURL = "https://api.coingecko.com/api/v3"
    
    private init() {}
    
    func searchCoinList(id: String, completionHandler: @escaping ([CoinMargetModel]) -> Void) {
        
        let urlString = "\(baseURL)/coins/markets"
        
        let parameters = [
            "vs_currency": "krw",
            "ids": id,
            "sparkline": "true"
        ]
        
        AF.request(
            urlString,
            method: .get,
            parameters: parameters,
            encoder: URLEncodedFormParameterEncoder(destination: .queryString)
        ).responseDecodable(of: [CoinMargetModel].self, queue: .global()) { response in
            switch response.result {
            case .success(let success):
                completionHandler(success)
            case .failure(let failure):
                print(failure)
            }
        }
    }
}
