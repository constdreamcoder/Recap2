//
//  CoingeckoTrendingAPIManager.swift
//  CryptoCoin
//
//  Created by SUCHAN CHANG on 3/3/24.
//

import Foundation
import Alamofire

final class CoingeckoTrendingAPIManager {
    static let shared = CoingeckoTrendingAPIManager()
    
    private let baseURL = "https://api.coingecko.com/api/v3/search/trending"
    
    private init() {}
    
    func fetchTopRankCoinList(completionHandler: @escaping (TrendingModel) -> Void) {
        AF.request(
            baseURL
        ).responseDecodable(of: TrendingModel.self) { response in
            switch response.result {
            case .success(let success):
                completionHandler(success)
            case .failure(let failure):
                print(failure)
            }
        }
    }
}
