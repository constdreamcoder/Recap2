//
//  MainTableViewCell.swift
//  CryptoCoin
//
//  Created by SUCHAN CHANG on 2/28/24.
//

import UIKit
import SnapKit
import Kingfisher

protocol MyFavoriteTableViewCellDelegate: AnyObject {
    func goToCoinChartVC(favorite: CoinMargetModel)
}

final class MyFavoriteTableViewCell: UITableViewCell {

    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: configureCollectionViewLayout())
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.register(MyFavoriteCollectionViewCell.self, forCellWithReuseIdentifier: MyFavoriteCollectionViewCell.identifier)
        
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    
    let favoriteCoinViewModel = FavoriteCoinViewModel()
    let coinChartViewModel = CoinChartViewModel()
    
    var favoriteList: [CoinMargetModel] = []
    
    weak var delegate: MyFavoriteTableViewCellDelegate?

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        favoriteCoinViewModel.inputViewDidLoadTrigger.value = ()
        
        configureTableViewCellConstraints()
        configureTableViewCellUI()
        bindings()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MyFavoriteTableViewCell: UITableViewCellConfigurationProtocol {
    func configureTableViewCellConstraints() {
        contentView.addSubview(collectionView)
        
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.height.equalTo(150)
        }
    }
    
    func configureTableViewCellUI() {
        
    }
    
    private func bindings() {
        favoriteCoinViewModel.outputFavoriteList.bind { favoriteList in
            DispatchQueue.main.async {
                if favoriteList.count >= 2 {
                    self.favoriteList = favoriteList
                    self.collectionView.reloadData()
                }
            }
        }
    }
}

extension MyFavoriteTableViewCell: UICollectionViewConfigurationProtocol {
    func configureCollectionViewLayout() -> UICollectionViewLayout {
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 200, height: 150)
        layout.minimumLineSpacing = 16
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        
        layout.scrollDirection = .horizontal
        
        return layout
    }
}

extension MyFavoriteTableViewCell: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.goToCoinChartVC(favorite: favoriteList[indexPath.item])
    }
}

extension MyFavoriteTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return favoriteList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MyFavoriteCollectionViewCell.identifier, for: indexPath) as? MyFavoriteCollectionViewCell else { return UICollectionViewCell() }
        
        let favorite = favoriteList[indexPath.item]
        
        let coinImageURL = URL(string: favorite.image)
        let placeholderImage = UIImage(systemName: "photo")
        cell.coinImageView.kf.setImage(with: coinImageURL, placeholder: placeholderImage)
        cell.coinStackView.coinNameLabel.text = favorite.name
        cell.coinStackView.symbolLabel.text = favorite.symbol.uppercased()
        cell.priceChangingStackView.priceLabel.text = favorite.current_price.convertToKRWCurrency
                
        if favorite.price_change_percentage_24h > 0 {
            cell.priceChangingStackView.priceChangingRateLabel.textColor = .customRed
            cell.priceChangingStackView.priceChangingRateLabel.text = "+" + favorite.price_change_percentage_24h.moveDecimalPointUtilTwoDecimalPlaces + "%"
        } else {
            cell.priceChangingStackView.priceChangingRateLabel.textColor = .customBlue
            cell.priceChangingStackView.priceChangingRateLabel.text = favorite.price_change_percentage_24h.moveDecimalPointUtilTwoDecimalPlaces + "%"
        }
                
        return cell
    }
}
