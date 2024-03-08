//
//  CoinStackView.swift
//  CryptoCoin
//
//  Created by SUCHAN CHANG on 2/27/24.
//

import UIKit

class CoinStackView: UIStackView {
    
    let coinNameLabel: UILabel = {
        let label = UILabel()
        label.text = "테스트"
        label.font = .systemFont(ofSize: 16.0, weight: .bold)
        return label
    }()
    
    let symbolLabel: UILabel = {
        let label = UILabel()
        label.text = "BTC"
        label.textColor = .lightGray
        label.font = .systemFont(ofSize: 14.0)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureUI()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        axis = .vertical
        spacing = 2.0
        alignment = .leading
        [
            coinNameLabel,
            symbolLabel
        ].forEach { addArrangedSubview($0) }
    }
}
