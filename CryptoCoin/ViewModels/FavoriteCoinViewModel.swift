//
//  FavoriteCoinViewModel.swift
//  CryptoCoin
//
//  Created by SUCHAN CHANG on 3/3/24.
//

import Foundation

final class FavoriteCoinViewModel {
    
    let inputViewDidLoadTrigger: Observable<Void?> = Observable(nil)
    
    let outputFavoriteList: Observable<[CoinMargetModel]> = Observable([])
    
    init() {
        inputViewDidLoadTrigger.bind { trigger in
            if trigger == nil {
                return
            }
            
            let group = DispatchGroup()

            var tempStorage: [CoinMargetModel] = []
            
            RealmRepository.shared.fetchFavoriteList().forEach { favorite in
                group.enter()
                CoinMarketAPIManager.shared.searchCoinList(id: favorite.id) { coinMargetModelList in
                    tempStorage.append(coinMargetModelList[0])
                    group.leave()
                }
            }
            
            group.notify(queue: .main) {
                self.outputFavoriteList.value = tempStorage
            }
           
        }
    }
}
