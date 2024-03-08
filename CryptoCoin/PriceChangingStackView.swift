//
//  PriceChangingStackView.swift
//  CryptoCoin
//
//  Created by SUCHAN CHANG on 2/29/24.
//

import UIKit

final class PriceChangingStackView: UIStackView {
    let priceLabel: UILabel = {
        let label = UILabel()
        label.text = "₩69,234,243"
        label.textColor = .customBlack
        label.font = .systemFont(ofSize: 18.0, weight: .semibold)
        return label
    }()
    
    let priceChangingRateLabel: UILabel = {
        let label = UILabel()
        label.text = "+0.64%"
        label.textColor = .customRed
        label.font = .systemFont(ofSize: 16.0, weight: .semibold)
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
        [
            priceLabel,
            priceChangingRateLabel
        ].forEach { addArrangedSubview($0) }
    }
    
    private func configureUI() {
        axis = .vertical
        alignment = .leading
        spacing = 8.0
    }
}
