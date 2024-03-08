//
//  FavoriteCoinCollectionViewCell.swift
//  CryptoCoin
//
//  Created by SUCHAN CHANG on 2/27/24.
//

import UIKit
import SnapKit

final class FavoriteCoinCollectionViewCell: UICollectionViewCell {
    
    let coinImageView = CoinImageView(frame: .zero)
    
    let coinStackView = CoinStackView()
    
    let priceLabel: UILabel = {
        let label = UILabel()
        label.text = "₩39,393,393"
        label.font = .systemFont(ofSize: 20.0, weight: .bold)
        return label
    }()
    
    lazy var priceChangeContainer: UIView = {
        let view = UIView()
        view.addSubview(priceChangeRateLabel)
        view.backgroundColor = .customLightRed
        view.clipsToBounds = true
        view.layer.cornerRadius = 8.0
        return view
    }()
    
    let priceChangeRateLabel: UILabel = {
        let label = UILabel()
        label.text = "+0.64%"
        label.textColor = .customRed
        label.font = .systemFont(ofSize: 14.0, weight: .semibold)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureCollectionViewCellConstraints()
        configureCollectionViewCellUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension FavoriteCoinCollectionViewCell: UICollectionViewCellConfigurationProtocol {
    func configureCollectionViewCellConstraints() {
        [
            coinImageView,
            coinStackView,
            priceLabel,
            priceChangeContainer
        ].forEach { contentView.addSubview($0) }
        
        coinImageView.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(16.0)
            $0.centerY.equalTo(coinStackView)
        }
        
        coinStackView.snp.makeConstraints {
            $0.leading.equalTo(coinImageView.snp.trailing).offset(8.0)
            $0.top.trailing.equalToSuperview().inset(16.0)
        }
        
        priceLabel.snp.makeConstraints {
            $0.trailing.equalTo(priceChangeContainer)
            $0.bottom.equalTo(priceChangeContainer.snp.top).offset(-8.0)
        }
        
        priceChangeContainer.snp.makeConstraints {
            $0.bottom.trailing.equalToSuperview().inset(16.0)
        }
        
        priceChangeRateLabel.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(8.0)
        }
    }
    
    func configureCollectionViewCellUI() {
        contentView.backgroundColor = .customLightGray
        contentView.layer.cornerRadius = 16.0
    }
}
