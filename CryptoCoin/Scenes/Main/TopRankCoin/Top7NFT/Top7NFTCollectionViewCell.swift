//
//  Top7NFTCollectionViewCell.swift
//  CryptoCoin
//
//  Created by SUCHAN CHANG on 3/3/24.
//

import UIKit
import Kingfisher

final class Top7NFTCollectionViewCell: TopRankCoinCollectionViewCell {
    
    var rankNFTList: [(Int, TMNFT)] = []

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        super.rankCoinTableView.delegate = self
        super.rankCoinTableView.dataSource = self
    }
}

extension Top7NFTCollectionViewCell: UITableViewDelegate {
    
}

extension Top7NFTCollectionViewCell: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rankNFTList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: RankCoinTableViewCell.identifier, for: indexPath) as? RankCoinTableViewCell else { return UITableViewCell() }
    
        let index = rankNFTList[indexPath.row].0
        let nft = rankNFTList[indexPath.row].1
        
        cell.leftStackView.rankLabel.text = "\(index + 1)"
        let nftImageURL = URL(string: nft.thumb)
        let placeholderImage = UIImage(systemName: "photo")
        cell.leftStackView.coinImageView.kf.setImage(with: nftImageURL, placeholder: placeholderImage)
        cell.leftStackView.coinStackView.coinNameLabel.text = nft.name
        cell.leftStackView.coinStackView.symbolLabel.text = nft.symbol
        cell.rightStackView.priceLabel.text = nft.data.floor_price
        
        let convertedDouble = Double(nft.data.floor_price_in_usd_24h_percentage_change) ?? 0
        if convertedDouble > 0 {
            cell.rightStackView.priceChangingLabel.textColor = .customRed
            cell.rightStackView.priceChangingLabel.text = "+" + nft.data.floor_price_in_usd_24h_percentage_change.doSomething + "%"
        } else {
            cell.rightStackView.priceChangingLabel.textColor = .customBlue
            cell.rightStackView.priceChangingLabel.text = nft.data.floor_price_in_usd_24h_percentage_change.doSomething + "%"
        }
        
        return cell
    }
}


