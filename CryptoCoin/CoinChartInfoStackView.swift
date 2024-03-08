//
//  CoinChartInfoBaseStackView.swift
//  CryptoCoin
//
//  Created by SUCHAN CHANG on 2/28/24.
//

import UIKit
import SnapKit

final class CoinChartInfoBaseStackView: UIStackView {
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "고가"
        label.textColor = .customRed
        label.font = .systemFont(ofSize: 20.0, weight: .bold)
        return label
    }()
    
    let priceLabel: UILabel = {
        let label = UILabel()
        label.text = "₩69,234,243"
        label.textColor = .customDarkGray
        label.font = .systemFont(ofSize: 18.0, weight: .semibold)
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
            titleLabel,
            priceLabel
        ].forEach { addArrangedSubview($0) }
    }
    
    private func configureUI() {
        axis = .vertical
        alignment = .leading
        spacing = 8.0
    }
}
