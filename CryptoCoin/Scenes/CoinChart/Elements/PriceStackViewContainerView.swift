//
//  PriceStackViewContainerView.swift
//  CryptoCoin
//
//  Created by SUCHAN CHANG on 2/28/24.
//

import UIKit

final class PriceStackViewContainerView: UIStackView {
    
    let highPriceStackView = PriceStackView()
    let lowPriceStackView = PriceStackView()
    
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
            highPriceStackView,
            lowPriceStackView
        ].forEach { addArrangedSubview($0) }
    }
    
    private func configureUI() {
        axis = .horizontal
        distribution = .equalCentering
        
        highPriceStackView.topPart.titleLabel.textColor = .customRed
        highPriceStackView.topPart.titleLabel.text = "고가"
        highPriceStackView.bottomPart.titleLabel.textColor = .customRed
        highPriceStackView.bottomPart.titleLabel.text = "신고점"
        
        lowPriceStackView.topPart.titleLabel.textColor = .customBlue
        lowPriceStackView.topPart.titleLabel.text = "저가"
        lowPriceStackView.bottomPart.titleLabel.textColor = .customBlue
        lowPriceStackView.bottomPart.titleLabel.text = "신저점"

    }
}
