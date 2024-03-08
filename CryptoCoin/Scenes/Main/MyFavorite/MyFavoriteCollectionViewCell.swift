//
//  MyFavoriteCollectionViewCell.swift
//  CryptoCoin
//
//  Created by SUCHAN CHANG on 2/28/24.
//

import UIKit
import SnapKit

final class MyFavoriteCollectionViewCell: UICollectionViewCell {
    
    let coinImageView = CoinImageView(frame: .zero)
    let coinStackView = CoinStackView()
    let priceChangingStackView = PriceChangingStackView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureCollectionViewCellConstraints()
        configureCollectionViewCellUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MyFavoriteCollectionViewCell: UICollectionViewCellConfigurationProtocol {
    func configureCollectionViewCellConstraints() {
        [
            coinImageView,
            coinStackView,
            priceChangingStackView
        ].forEach { contentView.addSubview($0) }
        
        coinImageView.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(16.0)
            $0.centerY.equalTo(coinStackView)
        }
        
        coinStackView.snp.makeConstraints {
            $0.leading.equalTo(coinImageView.snp.trailing).offset(8.0)
            $0.trailing.top.equalToSuperview().inset(16.0)
        }
        
        priceChangingStackView.snp.makeConstraints {
            $0.leading.equalTo(coinImageView)
            $0.trailing.bottom.equalToSuperview().inset(16.0)
        }
    }
    
    func configureCollectionViewCellUI() {
        contentView.backgroundColor = .customLightGray
        contentView.layer.cornerRadius = 16.0
    }
}
