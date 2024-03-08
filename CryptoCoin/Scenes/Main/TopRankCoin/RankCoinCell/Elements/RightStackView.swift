//
//  RightStackView.swift
//  CryptoCoin
//
//  Created by SUCHAN CHANG on 2/29/24.
//

import UIKit

final class RightStackView: UIStackView {
    
    let priceLabel: UILabel = {
        let label = UILabel()
        label.text = "$0.4175"
        label.font = .systemFont(ofSize: 18.0)
        label.textColor = .customBlack
        return label
    }()
    
    let priceChangingLabel: UILabel = {
        let label = UILabel()
        label.text = "+21.18%"
        label.textColor = .customRed
        label.font = .systemFont(ofSize: 16.0)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureConstraints()
        configureUI()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureConstraints() {
        [
            priceLabel,
            priceChangingLabel
        ].forEach { addArrangedSubview($0) }
    }
    
    private func configureUI() {
        axis = .vertical
        spacing = 4.0
        alignment = .trailing
    }
}
