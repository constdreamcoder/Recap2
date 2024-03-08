//
//  LabelStackView.swift
//  CryptoCoin
//
//  Created by SUCHAN CHANG on 2/28/24.
//

import UIKit

final class LabelStackView: UIStackView {
    
    let priceLabel: UILabel = {
        let label = UILabel()
        label.text = "₩69,234,245"
        label.textColor = .black
        label.font = .systemFont(ofSize: 32.0, weight: .bold)
        return label
    }()
    
    lazy var bottomStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 8.0
        [
            priceChagingRateLabel,
            dateLabel
        ].forEach { stackView.addArrangedSubview($0) }
        return stackView
    }()
    
    let priceChagingRateLabel: UILabel = {
        let label = UILabel()
        label.text = "+3.22%"
        label.textColor = .customRed
        label.font = .systemFont(ofSize: 18.0, weight: .semibold)
        return label
    }()
    
    let dateLabel: UILabel = {
        let label = UILabel()
        label.text = "Today"
        label.textColor = .customDarkGray
        label.font = .systemFont(ofSize: 18.0)

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
            bottomStackView
        ].forEach { addArrangedSubview($0) }
    }
    
    private func configureUI() {
        axis = .vertical
        spacing = 4.0
        alignment = .leading
    }
}
