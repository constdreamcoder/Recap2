//
//  Top15CoinCollectionViewCell.swift
//  CryptoCoin
//
//  Created by SUCHAN CHANG on 3/3/24.
//

import UIKit
import Kingfisher

final class Top15CoinCollectionViewCell: TopRankCoinCollectionViewCell {
    
    var rankCoinList: [(Int, TMCoin)] = []
    
    let presenter = Top15CoinCollectionViewCellPresenter()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureUI()
        bindings()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        super.rankCoinTableView.delegate = self
        super.rankCoinTableView.dataSource = self
    }
    
    private func bindings() {
        presenter.outputCoinChartData.bind { coinMargetModel in
            guard let coinMargetModel = coinMargetModel else { return }
            NotificationCenter.default.post(name: .transferData, object: nil, userInfo: ["coinMargetModel": coinMargetModel])
        }
    }
}

extension Top15CoinCollectionViewCell: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let coin = rankCoinList[indexPath.row].1
        presenter.inputSelectedCoin.value = coin.item.id
    }
}

extension Top15CoinCollectionViewCell: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rankCoinList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: RankCoinTableViewCell.identifier, for: indexPath) as? RankCoinTableViewCell else { return UITableViewCell() }
        
        let index = rankCoinList[indexPath.row].0
        let coin = rankCoinList[indexPath.row].1
        
        cell.leftStackView.rankLabel.text = "\(index + 1)"
        let coinImageURL = URL(string: coin.item.small)
        let placeholderImage = UIImage(systemName: "photo")
        cell.leftStackView.coinImageView.kf.setImage(with: coinImageURL, placeholder: placeholderImage)
        cell.leftStackView.coinStackView.coinNameLabel.text = coin.item.name
        cell.leftStackView.coinStackView.symbolLabel.text = coin.item.symbol
        cell.rightStackView.priceLabel.text = coin.item.data.price
        
        if coin.item.data.price_change_percentage_24h.krw > 0 {
            cell.rightStackView.priceChangingLabel.textColor = .customRed
            cell.rightStackView.priceChangingLabel.text = "+" + coin.item.data.price_change_percentage_24h.krw.moveDecimalPointUtilTwoDecimalPlaces + "%"
        } else {
            cell.rightStackView.priceChangingLabel.textColor = .customBlue
            cell.rightStackView.priceChangingLabel.text = coin.item.data.price_change_percentage_24h.krw.moveDecimalPointUtilTwoDecimalPlaces + "%"
        }
        
        
        return cell
    }
}

