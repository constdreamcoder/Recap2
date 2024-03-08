//
//  SearchTableViewCellPresenter.swift
//  CryptoCoin
//
//  Created by SUCHAN CHANG on 3/3/24.
//

import Foundation

final class SearchTableViewCellPresenter {
    
    let inputCellReuseTrigger: Observable<String?> = Observable(nil)
    
    let outputFavoriteStatus: Observable<Bool> = Observable(false)
    
    init() {
        inputCellReuseTrigger.bind { id in
            guard let id = id else { return }
            if let favorite = RealmRepository.shared.checkFavorite(id: id) {
                self.outputFavoriteStatus.value = true
            } else {
                self.outputFavoriteStatus.value = false
            }
        }
    }
}
