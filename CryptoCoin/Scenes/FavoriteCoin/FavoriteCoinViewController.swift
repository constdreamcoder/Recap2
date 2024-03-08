//
//  FavoriteCoinViewController.swift
//  CryptoCoin
//
//  Created by SUCHAN CHANG on 2/27/24.
//

import UIKit
import SnapKit
import Kingfisher

final class FavoriteCoinViewController: UIViewController {
    
    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: configureCollectionViewLayout())
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.register(FavoriteCoinCollectionViewCell.self, forCellWithReuseIdentifier: FavoriteCoinCollectionViewCell.identifier)
        
        return collectionView
    }()
    
    let viewModel = FavoriteCoinViewModel()
    
    var favoriteList: [CoinMargetModel] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.inputViewDidLoadTrigger.value = ()
        
        configureNavigationBar()
        configureConstraints()
        bindings()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationItem.title = "Favorite Coin"
    }
}

extension FavoriteCoinViewController: UIViewControllerConfigurationProtocol {
    func configureNavigationBar() {
        navigationItem.largeTitleDisplayMode = .always
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func configureConstraints() {
        view.addSubview(collectionView)
        
        collectionView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    func configureUI() {
        
    }
    
    func configureUserEvents() {
        
    }
    
    private func bindings() {
        viewModel.outputFavoriteList.bind { favoriteList in
            self.favoriteList = favoriteList
            self.collectionView.reloadData()
        }
    }
}

extension FavoriteCoinViewController: UICollectionViewConfigurationProtocol {
    func configureCollectionViewLayout() -> UICollectionViewLayout {
        let spacing: CGFloat = 16
        
        let layout = UICollectionViewFlowLayout()
        let itemSize = UIScreen.main.bounds.width - (spacing * 3)
        layout.itemSize = CGSize(width: itemSize / 2, height: (itemSize / 2))
        layout.minimumLineSpacing = spacing
        layout.minimumInteritemSpacing = spacing
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        
        return layout
    }
}

extension FavoriteCoinViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let coinChartVC = CoinChartViewController()
        coinChartVC.coinMargetModel = favoriteList[indexPath.item]
        navigationController?.pushViewController(coinChartVC, animated: true)
    }
}

extension FavoriteCoinViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return favoriteList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FavoriteCoinCollectionViewCell.identifier, for: indexPath) as? FavoriteCoinCollectionViewCell else { return UICollectionViewCell() }
        
        let favorite = favoriteList[indexPath.item]
        
        let coinImageURL = URL(string: favorite.image)
        let placeholderImage = UIImage(systemName: "photo")
        cell.coinImageView.kf.setImage(with: coinImageURL, placeholder: placeholderImage)
        cell.coinStackView.coinNameLabel.text = favorite.name
        cell.coinStackView.symbolLabel.text = favorite.symbol.uppercased()
        
        cell.priceLabel.text = favorite.current_price.convertToKRWCurrency
        
        if favorite.price_change_percentage_24h > 0 {
            cell.priceChangeContainer.backgroundColor = .customLightRed
            cell.priceChangeRateLabel.textColor = .customRed
            cell.priceChangeRateLabel.text = "+" + favorite.price_change_percentage_24h.moveDecimalPointUtilTwoDecimalPlaces + "%"
        } else {
            cell.priceChangeContainer.backgroundColor = .customLightBlue
            cell.priceChangeRateLabel.textColor = .customBlue
            cell.priceChangeRateLabel.text = favorite.price_change_percentage_24h.moveDecimalPointUtilTwoDecimalPlaces + "%"
        }
        
        return cell
    }
}
