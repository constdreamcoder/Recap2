//
//  RankCoinTableViewCell.swift
//  CryptoCoin
//
//  Created by SUCHAN CHANG on 2/29/24.
//

import UIKit
import SnapKit

final class RankCoinTableViewCell: UITableViewCell {
    
    lazy var containerView: UIView = {
        let view = UIView()
        [
            leftStackView,
            rightStackView
        ].forEach { view.addSubview($0) }
        return view
    }()
    
    let leftStackView = LeftStackView()
    
    let rightStackView = RightStackView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureTableViewCellConstraints()
        configureTableViewCellUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension RankCoinTableViewCell: UITableViewCellConfigurationProtocol {
    func configureTableViewCellConstraints() {
        contentView.addSubview(containerView)
        
        containerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.height.equalTo(80)
        }
        
        leftStackView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().inset(16.0)
            $0.trailing.lessThanOrEqualTo(rightStackView.snp.leading).offset(-16.0)
        }
        
        rightStackView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(24.0)
        }
    }
    
    func configureTableViewCellUI() {
        
    }
}
