//
//  Top15CoinTableViewCell.swift
//  CryptoCoin
//
//  Created by SUCHAN CHANG on 3/3/24.
//

import UIKit

final class Top15CoinTableViewCell: TopRankCoinTableViewCell {
        
    private let presenter = TopRankCoinTableViewCellPresenter()
    
    var top15CoinList: [[(Int, TMCoin)]] = []
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        presenter.inputCellInitializerTrigger.value = ()
        
        configureUI()
        bindings()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(Top15CoinCollectionViewCell.self, forCellWithReuseIdentifier: Top15CoinCollectionViewCell.identifier)
    }
    
    private func bindings() {
        presenter.outputTop15CoinList.bind { top15CoinList in
            
            self.top15CoinList = top15CoinList
            super.collectionView.reloadData()
        }
    }
}

extension Top15CoinTableViewCell: UICollectionViewDelegate {
    
}

extension Top15CoinTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return top15CoinList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Top15CoinCollectionViewCell.identifier, for: indexPath) as? Top15CoinCollectionViewCell else { return UICollectionViewCell() }
        cell.rankCoinList = top15CoinList[indexPath.item]
        cell.rankCoinTableView.reloadData()
        return cell
    }
}
