//
//  CoinImageView.swift
//  CryptoCoin
//
//  Created by SUCHAN CHANG on 2/27/24.
//

import UIKit
import SnapKit

class CoinImageView: UIImageView {
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureConstraints()
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureConstraints() {
        self.snp.makeConstraints {
            $0.size.equalTo(32.0)
        }
    }
    
    private func configureUI() {
        image = UIImage(systemName: "photo")
        tintColor = .customBlack
    }
}
