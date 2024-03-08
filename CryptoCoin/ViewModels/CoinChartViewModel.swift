//
//  CoinChartViewModel.swift
//  CryptoCoin
//
//  Created by SUCHAN CHANG on 3/3/24.
//

import Foundation

final class CoinChartViewModel {
    
    let inputViewDidLoadTrigger: Observable<String> = Observable("")
    let inputRightBarButtonTapTrigger: Observable<CoinMargetModel?> = Observable(nil)
    
    let outputFavoriteStatus: Observable<Bool> = Observable(false)
    let outputAlertFavoriteCountLimitMessage: Observable<String?> = Observable(nil)
    let outputToastMessage: Observable<String?> = Observable(nil)
    
    init() {
        inputViewDidLoadTrigger.bind { id in
            if let favorite = RealmRepository.shared.checkFavorite(id: id) {
                self.outputFavoriteStatus.value = true
            } else {
                self.outputFavoriteStatus.value = false
            }
        }
        
        inputRightBarButtonTapTrigger.bind { coinMargetModel in
            guard let coinMargetModel = coinMargetModel else { return }
            
            if let favorite = RealmRepository.shared.checkFavorite(id: coinMargetModel.id) {
                RealmRepository.shared.deleteFavorite(favorite: favorite)
                self.outputFavoriteStatus.value = false
                self.outputToastMessage.value = "즐거찾기에서 해제되었습니다."
            } else {
                if RealmRepository.shared.fetchFavoriteList().count >= 10 {
                    self.outputAlertFavoriteCountLimitMessage.value = "즐겨찾기 추가 개수는 최대 10개를 넘어갈 수 없습니다."
                } else {
                    RealmRepository.shared.addNewFavorite(id: coinMargetModel.id, name: coinMargetModel.name, symbol: coinMargetModel.symbol, imageURLString: coinMargetModel.image)
                    self.outputFavoriteStatus.value = true
                    self.outputToastMessage.value = "즐거찾기에 추가되었습니다."
                }
            }
        }
    }
}
