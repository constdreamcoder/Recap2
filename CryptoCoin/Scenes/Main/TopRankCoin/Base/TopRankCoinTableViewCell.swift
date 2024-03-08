//
//  Top15CoinTableViewCell.swift
//  CryptoCoin
//
//  Created by SUCHAN CHANG on 2/29/24.
//

import UIKit
import SnapKit

class TopRankCoinTableViewCell: UITableViewCell {
    
    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: configureCollectionViewLayout())
        
        collectionView.showsHorizontalScrollIndicator = false
        
        return collectionView
    }()
                
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
            
        configureTableViewCellConstraints()
        configureTableViewCellUI()
        binding()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension TopRankCoinTableViewCell: UITableViewCellConfigurationProtocol {
    func configureTableViewCellConstraints() {
        contentView.addSubview(collectionView)
        
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.height.equalTo(240)
        }
    }
    
    func configureTableViewCellUI() {
        
    }
    
    private func binding() {
      
    }
}

extension TopRankCoinTableViewCell: UICollectionViewConfigurationProtocol {
    func configureCollectionViewLayout() -> UICollectionViewLayout {
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 300, height: 240)
        layout.minimumLineSpacing = 16
        layout.minimumInteritemSpacing = 16
        layout.sectionInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        layout.scrollDirection = .horizontal
        
        return layout
    }
}
