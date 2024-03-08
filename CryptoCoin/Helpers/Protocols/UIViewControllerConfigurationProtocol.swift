//
//  UIViewControllerConfigurationProtocol.swift
//  CryptoCoin
//
//  Created by SUCHAN CHANG on 2/27/24.
//

import Foundation

protocol UIViewControllerConfigurationProtocol: AnyObject {
    func configureNavigationBar()
    func configureConstraints()
    func configureUI()
    func configureUserEvents()
}
