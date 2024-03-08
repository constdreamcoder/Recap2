//
//  CoingeckoAPIManager.swift
//  CryptoCoin
//
//  Created by SUCHAN CHANG on 3/1/24.
//

import Alamofire

final class CoingeckoAPIManager {
    static let shared = CoingeckoAPIManager()
    
    private let baseURL = "https://api.coingecko.com/api/v3"
    
    private init() {}
    
    func searchCoinList(keyword query: String, completionHandler: @escaping ([SMCoin]) -> Void) {
        
        let urlString = "\(baseURL)/search"
        
        let parameters = [
            "query": query
        ]
        
        AF.request(
            urlString,
            method: .get,
            parameters: parameters,
            encoder: URLEncodedFormParameterEncoder(destination: .queryString)
        ).responseDecodable(of: SearchModel.self) { response in
            switch response.result {
            case .success(let success):
                completionHandler(success.coins)
            case .failure(let failure):
                print(failure)
            }
        }
    }
}
