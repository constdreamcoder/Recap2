//
//  TabBarController.swift
//  CryptoCoin
//
//  Created by SUCHAN CHANG on 2/29/24.
//

import UIKit

final class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        let mainVC = MainViewController()
        let searchCoinVC = SearchCoinViewController()
        let favoriteVC = FavoriteCoinViewController()
        let userVC = UIViewController()
        
        userVC.view.backgroundColor = .white
        
        mainVC.tabBarItem.image = UIImage(named: "tab_trend_inactive")?.withRenderingMode(.alwaysOriginal)
        mainVC.tabBarItem.selectedImage = UIImage(named: "tab_trend")?.withRenderingMode(.alwaysOriginal)
        
        searchCoinVC.tabBarItem.image = UIImage(named: "tab_search_inactive")?.withRenderingMode(.alwaysOriginal)
        searchCoinVC.tabBarItem.selectedImage = UIImage(named: "tab_search")?.withRenderingMode(.alwaysOriginal)
        
        favoriteVC.tabBarItem.image = UIImage(named: "tab_portfolio_inactive")?.withRenderingMode(.alwaysOriginal)
        favoriteVC.tabBarItem.selectedImage = UIImage(named: "tab_portfolio")?.withRenderingMode(.alwaysOriginal)
        
        userVC.tabBarItem.image = UIImage(named: "tab_user_inactive")?.withRenderingMode(.alwaysOriginal)
        userVC.tabBarItem.selectedImage = UIImage(named: "tab_user")?.withRenderingMode(.alwaysOriginal)
        
        let navigationMain = UINavigationController(rootViewController: mainVC)
        let navigationSearch = UINavigationController(rootViewController: searchCoinVC)
        let navigationFavorite = UINavigationController(rootViewController: favoriteVC)
        let navigationUser = UINavigationController(rootViewController: userVC)
        
        setViewControllers([navigationMain, navigationSearch, navigationFavorite, navigationUser], animated: true)
    }
    
}
