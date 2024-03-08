//
//  MainViewModel.swift
//  CryptoCoin
//
//  Created by SUCHAN CHANG on 3/3/24.
//

import Foundation

final class TopRankCoinTableViewCellPresenter {
    
    let inputCellInitializerTrigger: Observable<Void?> = Observable(nil)
    
    let outputTop15CoinList: Observable<[[(Int, TMCoin)]]> = Observable([])
    let outputTop7NFTList: Observable<[[(Int, TMNFT)]]> = Observable([])
    
    init() {
        inputCellInitializerTrigger.bind { trigger in
            if trigger == nil {
                return
            }
            
            CoingeckoTrendingAPIManager.shared.fetchTopRankCoinList { trendingModel in
                let sortedCoinTendingModel = trendingModel.coins.sorted { tmCoin1, tmCoin2 in
                    tmCoin1.item.market_cap_rank < tmCoin2.item.market_cap_rank
                }
                let convertedCoinTrendingModel = sortedCoinTendingModel.enumerated().map { ($0, $1) }
                self.outputTop15CoinList.value = Array(convertedCoinTrendingModel.chunked(into: 3))
                
                let convertedNFTTrendingModel = trendingModel.nfts.enumerated().map { ($0, $1) }
                
                self.outputTop7NFTList.value = Array(convertedNFTTrendingModel.chunked(into: 3))
            }
        }
    }
}
