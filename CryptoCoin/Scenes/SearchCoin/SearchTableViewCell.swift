//
//  SearchTableViewCell.swift
//  CryptoCoin
//
//  Created by SUCHAN CHANG on 2/27/24.
//

import UIKit
import Kingfisher
import SnapKit

final class SearchTableViewCell: UITableViewCell {
    
    let coinImageView = CoinImageView(frame: .zero)
    
    let coinstackView = CoinStackView()
    
    let favoriteButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "btn_star")?.withRenderingMode(.alwaysOriginal), for: .normal)
        return button
    }()
    
    let presenter = SearchTableViewCellPresenter()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
                
        configureTableViewCellConstraints()
        bindings()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func representSearchText(searchText: String?) {
        if
            let coinNameText = coinstackView.coinNameLabel.text,
            let searchText = searchText,
            searchText != "" {
            if coinNameText.lowercased().contains(searchText.lowercased()) {
                let attributedString = NSMutableAttributedString(string: coinNameText)
                attributedString.addAttribute(.foregroundColor, value: UIColor.customPurple, range: ((coinNameText.lowercased()) as NSString).range(of: searchText.lowercased()))
                coinstackView.coinNameLabel.attributedText = attributedString
            }
        }
    }
}

extension SearchTableViewCell: UITableViewCellConfigurationProtocol {
    func configureTableViewCellConstraints() {
        [
            coinImageView,
            coinstackView,
            favoriteButton
        ].forEach { contentView.addSubview($0) }
        
        coinImageView.snp.makeConstraints {
            $0.size.equalTo(32.0)
            $0.leading.equalToSuperview().inset(16.0)
            $0.centerY.equalTo(coinstackView)
        }
        
        coinstackView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(8.0)
            $0.leading.equalTo(coinImageView.snp.trailing).offset(16.0)
            $0.trailing.greaterThanOrEqualTo(favoriteButton.snp.leading).offset(8.0)
        }
        
        favoriteButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(16.0)
            $0.centerY.equalTo(coinstackView)
        }
    }
    
    func configureTableViewCellUI() {
        
    }
    
    private func bindings() {
        presenter.outputFavoriteStatus.bind { isAdded in
            if isAdded {
                self.favoriteButton.setImage(UIImage(named: "btn_star_fill")?.withRenderingMode(.alwaysOriginal), for: .normal)
            } else {
                self.favoriteButton.setImage(UIImage(named: "btn_star")?.withRenderingMode(.alwaysOriginal), for: .normal)
            }
            
        }
    }
}
