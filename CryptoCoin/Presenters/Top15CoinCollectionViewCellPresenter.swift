//
//  Top15CoinCollectionViewCellPresenter.swift
//  CryptoCoin
//
//  Created by SUCHAN CHANG on 3/3/24.
//

import Foundation

final class Top15CoinCollectionViewCellPresenter {
    
    let inputSelectedCoin: Observable<String?> = Observable(nil)
    
    let outputCoinChartData: Observable<CoinMargetModel?> = Observable(nil)
    
    init() {
        
        inputSelectedCoin.bind { id in
            guard let id = id else { return }

            CoinMarketAPIManager.shared.searchCoinList(id: id) { coinMargetModelList in
                self.outputCoinChartData.value = coinMargetModelList.first
            }
        }
    }
}
