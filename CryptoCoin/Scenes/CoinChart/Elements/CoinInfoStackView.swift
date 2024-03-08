//
//  CoinInfoStackView.swift
//  CryptoCoin
//
//  Created by SUCHAN CHANG on 2/28/24.
//

import UIKit
import SnapKit

final class CoinInfoStackView: UIStackView {
    
    let coinImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "star")
        return imageView
    }()
    
    let coinNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Solana"
        label.textColor = .black
        label.font = .systemFont(ofSize: 32.0, weight: .bold)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureConstraint()
        configureUI()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureConstraint() {
        coinImageView.snp.makeConstraints {
            $0.size.equalTo(32.0)
        }
    }
    
    private func configureUI() {
        axis = .horizontal
        spacing = 4.0
        [
            coinImageView,
            coinNameLabel
        ].forEach { addArrangedSubview($0) }
    }
}
