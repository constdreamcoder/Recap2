//
//  Top15CoinCollectionViewCell.swift
//  CryptoCoin
//
//  Created by SUCHAN CHANG on 2/29/24.
//

import UIKit
import SnapKit

class TopRankCoinCollectionViewCell: UICollectionViewCell {
    
    lazy var rankCoinTableView: UITableView = {
        let tableView = UITableView()
                
        tableView.register(RankCoinTableViewCell.self, forCellReuseIdentifier: RankCoinTableViewCell.identifier)
        
        tableView.isScrollEnabled = false
        
        return tableView
    }()
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureCollectionViewCellConstraints()
        configureCollectionViewCellUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension TopRankCoinCollectionViewCell: UICollectionViewCellConfigurationProtocol {
    func configureCollectionViewCellConstraints() {
        contentView.addSubview(rankCoinTableView)
        
        rankCoinTableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    func configureCollectionViewCellUI() {
        
    }
}
