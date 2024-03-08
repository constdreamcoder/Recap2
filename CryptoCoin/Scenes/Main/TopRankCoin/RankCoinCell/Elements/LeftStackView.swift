//
//  LeftStackView.swift
//  CryptoCoin
//
//  Created by SUCHAN CHANG on 2/29/24.
//

import UIKit

final class LeftStackView: UIStackView {
    
    let rankLabel: UILabel = {
        let label = UILabel()
        label.text = "1"
        label.textColor = .customBlack
        label.font = .boldSystemFont(ofSize: 20)
        return label
    }()
    
    let coinImageView = CoinImageView(frame: .zero)
    
    let coinStackView = CoinStackView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureConstraint()
        configureUI()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureConstraint() {
        [
            rankLabel,
            coinImageView,
            coinStackView
        ].forEach { addArrangedSubview($0) }
    }
    
    private func configureUI() {
        axis = .horizontal
        spacing = 8.0
        alignment = .center
        distribution = .equalSpacing
    }
}
