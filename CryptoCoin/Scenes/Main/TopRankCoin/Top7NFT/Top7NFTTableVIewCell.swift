//
//  Top7NFTTableVIewCell.swift
//  CryptoCoin
//
//  Created by SUCHAN CHANG on 3/3/24.
//

import UIKit

final class Top7NFTTableVIewCell: TopRankCoinTableViewCell {
        
    private let presenter = TopRankCoinTableViewCellPresenter()
    
    var top7NFTList: [[(Int, TMNFT)]] = []
    
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
        
        collectionView.register(Top7NFTCollectionViewCell.self, forCellWithReuseIdentifier: Top7NFTCollectionViewCell.identifier)
    }
    
    private func bindings() {
        presenter.outputTop7NFTList.bind { top7NFTList in
            self.top7NFTList = top7NFTList
            super.collectionView.reloadData()
        }
    }
}

extension Top7NFTTableVIewCell: UICollectionViewDelegate {
    
}

extension Top7NFTTableVIewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return top7NFTList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Top7NFTCollectionViewCell.identifier, for: indexPath) as? Top7NFTCollectionViewCell else { return UICollectionViewCell() }
        cell.rankNFTList = top7NFTList[indexPath.item]
        return cell
    }
}


