//
//  MainViewController.swift
//  CryptoCoin
//
//  Created by SUCHAN CHANG on 2/28/24.
//

import UIKit
import SnapKit

final class MainViewController: UIViewController {
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(MyFavoriteTableViewCell.self, forCellReuseIdentifier: MyFavoriteTableViewCell.identifier)
        tableView.register(Top15CoinTableViewCell.self, forCellReuseIdentifier: Top15CoinTableViewCell.identifier)
        tableView.register(Top7NFTTableVIewCell.self, forCellReuseIdentifier: Top7NFTTableVIewCell.identifier)
        
        tableView.separatorStyle = .none
        
        return tableView
    }()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavigationBar()
        configureConstraints()
        configureUserEvents()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationItem.title = "Crypto Coin"
    }
}

extension MainViewController {
    @objc func goToCoinCharVC(notification: Notification) {
        guard let coinMargetModel = notification.userInfo?["coinMargetModel"] as? CoinMargetModel else { return }
        DispatchQueue.main.async {
            let coinChartVC = CoinChartViewController()
            coinChartVC.coinMargetModel = coinMargetModel
            self.navigationController?.pushViewController(coinChartVC, animated: true)
        }
    }
}

extension MainViewController: UIViewControllerConfigurationProtocol {
    func configureNavigationBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func configureConstraints() {
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    func configureUI() {
        
    }
    
    func configureUserEvents() {
        NotificationCenter.default.addObserver(self, selector: #selector(goToCoinCharVC), name: .transferData, object: nil)
    }
}

extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return MainTableViewSection.allCases[section].rawValue
    }
}

extension MainViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return MainTableViewSection.allCases.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: MyFavoriteTableViewCell.identifier, for: indexPath) as? MyFavoriteTableViewCell else { return UITableViewCell() }
            cell.delegate = self
            return cell
        } else if indexPath.section == 1 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: Top15CoinTableViewCell.identifier, for: indexPath) as? Top15CoinTableViewCell else { return UITableViewCell() }
            return cell
        } else if indexPath.section == 2 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: Top7NFTTableVIewCell.identifier, for: indexPath) as? Top7NFTTableVIewCell else { return UITableViewCell() }
            return cell
        }
        
        return UITableViewCell()
    }
}

extension MainViewController: MyFavoriteTableViewCellDelegate {
    func goToCoinChartVC(favorite: CoinMargetModel) {
        let coinChartVC = CoinChartViewController()
        coinChartVC.coinMargetModel = favorite
        navigationController?.pushViewController(coinChartVC, animated: true)
    }
}
