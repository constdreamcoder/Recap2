//
//  SearchViewController.swift
//  CryptoCoin
//
//  Created by SUCHAN CHANG on 2/27/24.
//

import UIKit
import SnapKit
import Kingfisher
import Toast

final class SearchCoinViewController: UIViewController {
    
    lazy var searchController: UISearchController = {
        let searchController = UISearchController()
        searchController.searchBar.placeholder = "검색할 코인을 입력해주세요"
        searchController.hidesNavigationBarDuringPresentation = false
        
        searchController.searchBar.delegate = self
        
        return searchController
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(SearchTableViewCell.self, forCellReuseIdentifier: SearchTableViewCell.identifier)
        
        tableView.separatorStyle = .none
        
        return tableView
    }()
    
    let viewModel = SearchCoinViewModel()
    
    var coinList: [SMCoin] = []

    override func viewDidLoad() {
        super.viewDidLoad()
                
        configureNavigationBar()
        configureConstraints()
        configureUI()
        binding()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationItem.title = "Search"
        tableView.reloadData()
    }
}

extension SearchCoinViewController {
    @objc func favoriteButtonTapped(_ button: UIButton) {
        viewModel.inputFavoriteButtonTapTrigger.value = (coinList[button.tag], button.tag)
    }
}

extension SearchCoinViewController: UIViewControllerConfigurationProtocol {
    func configureNavigationBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
        
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    func configureConstraints() {
        [
            tableView
        ].forEach { view.addSubview($0) }
        
        tableView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    func configureUI() {
        
    }
    
    func configureUserEvents() {
        
    }
    
    private func binding() {
        viewModel.outputSearchCoinTableViewData.bind { coinList in
            self.coinList = coinList
            self.tableView.reloadData()
        }
        
        viewModel.outputCoinChartDate.bind { coinMargetModel in
            guard let coinMargetModel = coinMargetModel else { return }
            
            DispatchQueue.main.async {
                let coinChartVC = CoinChartViewController()
                coinChartVC.coinMargetModel = coinMargetModel
                self.navigationController?.pushViewController(coinChartVC, animated: true)
            }
        }
        
        viewModel.outputFavoriteExistenceCheck.bind { index in
            guard let index = index else { return }
            guard let cell = self.tableView.cellForRow(at: IndexPath(row: index, section: 0)) as? SearchTableViewCell else { return }

            cell.presenter.inputCellReuseTrigger.value = self.coinList[index].id
            
            self.tableView.reloadRows(at: [IndexPath(row: index, section: 0)], with: .none)
        }
        
        viewModel.outputAlertFavoriteCountLimitMessage.bind { message in
            guard let message = message else { return }
            
            let alert = UIAlertController(title: "즐겨찾기 개수 제한", message: message, preferredStyle: .alert)
            
            let confirtmButton = UIAlertAction(title: "확인", style: .default)
            
            alert.addAction(confirtmButton)
            
            self.present(alert, animated: true)
        }
        
        viewModel.outputToastMessage.bind { message in
            self.view.makeToast(message)
        }
    }
}

extension SearchCoinViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.inputSelectedCoin.value = coinList[indexPath.row]
    }
}

extension SearchCoinViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return coinList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchTableViewCell.identifier, for: indexPath) as? SearchTableViewCell else { return UITableViewCell() }

        let coin = coinList[indexPath.row]
        let url = URL(string: coin.large)
        cell.coinImageView.kf.setImage(with: url, placeholder: UIImage(systemName: "photo"))
        cell.coinstackView.coinNameLabel.text = coin.name
        cell.coinstackView.symbolLabel.text = coin.symbol

        cell.representSearchText(searchText: searchController.searchBar.text)
        cell.favoriteButton.tag = indexPath.row
        cell.favoriteButton.addTarget(self, action: #selector(favoriteButtonTapped), for: .touchUpInside)
        
        cell.presenter.inputCellReuseTrigger.value = coin.id
        
        return cell
    }
}

extension SearchCoinViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text else { return }
        
        if !text.isEmpty {
            viewModel.inputText.value = text.trimmingCharacters(in: .whitespacesAndNewlines)
        }
    }
}
