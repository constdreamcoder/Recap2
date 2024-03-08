//
//  PriceStackView.swift
//  CryptoCoin
//
//  Created by SUCHAN CHANG on 2/28/24.
//

import UIKit
import SnapKit

final class PriceStackView: UIStackView {
    
    let topPart = CoinChartInfoBaseStackView()
    let bottomPart = CoinChartInfoBaseStackView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureConstraint()
        configureUI()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureConstraint() {
        [topPart, bottomPart].forEach { addArrangedSubview($0) }
        let spacing: CGFloat = 16.0
        let width = (UIScreen.main.bounds.width - (spacing * 3)) / 2
        self.snp.makeConstraints {
            $0.width.equalTo(width)
        }
    }
    private func configureUI() {
        axis = .vertical
        spacing = 16.0
        alignment = .leading
    }
}
