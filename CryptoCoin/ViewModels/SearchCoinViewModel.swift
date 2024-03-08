//
//  SearchCoinViewModel.swift
//  CryptoCoin
//
//  Created by SUCHAN CHANG on 3/1/24.
//

import Foundation

final class SearchCoinViewModel {
    let inputText: Observable<String> = Observable("")
    let inputSelectedCoin: Observable<SMCoin?> = Observable(nil)
    let inputFavoriteButtonTapTrigger: Observable<(SMCoin?, Int?)> = Observable((nil, nil))
    
    let outputSearchCoinTableViewData: Observable<[SMCoin]> = Observable([])
    let outputCoinChartDate: Observable<CoinMargetModel?> = Observable(nil)
    let outputFavoriteExistenceCheck: Observable<Int?> = Observable(nil)
    let outputAlertFavoriteCountLimitMessage: Observable<String?> = Observable(nil)
    let outputToastMessage: Observable<String?> = Observable(nil)
    
    init() {
        inputText.bind { searchKeyword in
            CoingeckoAPIManager.shared.searchCoinList(keyword: searchKeyword) { searchCoinList in
                self.outputSearchCoinTableViewData.value = searchCoinList
            }
        }
        
        inputSelectedCoin.bind { coin in
            guard let coin = coin else { return }
            CoinMarketAPIManager.shared.searchCoinList(id: coin.id) { coinMargetModel in
                self.outputCoinChartDate.value = coinMargetModel[0]
            }
        }
        
        inputFavoriteButtonTapTrigger.bind { coin, index in
            guard let coin = coin else { return }
            
            if let favorite = RealmRepository.shared.checkFavorite(id: coin.id) {
                RealmRepository.shared.deleteFavorite(favorite: favorite)
                self.outputToastMessage.value = "즐겨찾기에서 해제되었습니다."
            } else {
                if RealmRepository.shared.fetchFavoriteList().count >= 10 {
                    self.outputAlertFavoriteCountLimitMessage.value = "즐겨찾기 추가 개수는 최대 10개를 넘어갈 수 없습니다."
                } else {
                    RealmRepository.shared.addNewFavorite(id: coin.id, name: coin.name, symbol: coin.symbol, imageURLString: coin.large)
                    self.outputToastMessage.value = "즐겨찾기에 추가되었습니다."
                }
            }
            
            self.outputFavoriteExistenceCheck.value = index
        }
    }
}
