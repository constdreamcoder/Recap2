//
//  CoinChartViewController.swift
//  CryptoCoin
//
//  Created by SUCHAN CHANG on 2/28/24.
//

import UIKit
import SnapKit
import Kingfisher
import DGCharts

final class CoinChartViewController: UIViewController {
    
    let coinInfoStackView = CoinInfoStackView()
    let labelStackView = LabelStackView()
    let priceStackViewContainerView = PriceStackViewContainerView()
    
    let lineChartView: LineChartView = {
        let lineChartView = LineChartView()
        lineChartView.rightAxis.enabled = false
        lineChartView.leftAxis.enabled = false
        lineChartView.xAxis.enabled = false
        return lineChartView
    }()
    
    let lastUpdatedLabel: UILabel = {
        let label = UILabel()
        label.text = "2/21 11:53:50 업데이트"
        label.textColor = .customDarkGray
        label.font = .systemFont(ofSize: 14.0)
        return label
    }()
    
    let viewModel = CoinChartViewModel()
    
    var coinMargetModel: CoinMargetModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let coinMargetModel = coinMargetModel {
            viewModel.inputViewDidLoadTrigger.value = coinMargetModel.id
        }
        
        configureNavigationBar()
        configureConstraints()
        configureUI()
        configureUserEvents()
        bindings()
        configureLineChartViewUI()
    }
}

extension CoinChartViewController {
    @objc func rightBarButtonTapped() {
        viewModel.inputRightBarButtonTapTrigger.value = coinMargetModel
    }
}

extension CoinChartViewController: UIViewControllerConfigurationProtocol {
    func configureNavigationBar() {
        
        navigationItem.largeTitleDisplayMode = .never
        
        navigationController?.navigationBar.topItem?.title = ""
        navigationController?.navigationBar.tintColor = .customPurple
        
        viewModel.outputFavoriteStatus.bind { isAdded in
            var rightBarButtonItemImage = UIImage()
            
            if isAdded {
                rightBarButtonItemImage = (UIImage(named: "btn_star_fill")?.withTintColor(.customPurple, renderingMode: .alwaysOriginal))!
            } else {
                rightBarButtonItemImage = (UIImage(named: "btn_star")?.withTintColor(.customPurple, renderingMode: .alwaysOriginal))!
            }
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(
                image: rightBarButtonItemImage,
                style: .plain,
                target: self,
                action: #selector(self.rightBarButtonTapped)
            )
        }
        
    }
    
    func configureConstraints() {
        [
            coinInfoStackView,
            labelStackView,
            priceStackViewContainerView,
            lineChartView,
            lastUpdatedLabel
        ].forEach { view.addSubview($0) }
        
        coinInfoStackView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.equalTo(view.safeAreaLayoutGuide).inset(16.0)
        }
        
        labelStackView.snp.makeConstraints {
            $0.top.equalTo(coinInfoStackView.snp.bottom).offset(16.0)
            $0.leading.equalTo(coinInfoStackView)
        }
        
        priceStackViewContainerView.snp.makeConstraints {
            $0.top.equalTo(labelStackView.snp.bottom).offset(32.0)
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(16.0)
        }
        
        lineChartView.snp.makeConstraints {
            $0.top.equalTo(priceStackViewContainerView.snp.bottom).offset(16.0)
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(16.0)
        }
        
        lastUpdatedLabel.snp.makeConstraints {
            $0.top.equalTo(lineChartView.snp.bottom).offset(8.0)
            $0.trailing.equalTo(lineChartView).inset(16.0)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(32.0)
            
        }
    }
    
    func configureUI() {
        view.backgroundColor = .white
        
        guard let coinMargetModel = coinMargetModel else { return }
        let coinImageURL = URL(string: coinMargetModel.image)
        coinInfoStackView.coinImageView.kf.setImage(with: coinImageURL, placeholder: UIImage(systemName: "photo"))
        coinInfoStackView.coinNameLabel.text = coinMargetModel.name
        labelStackView.priceLabel.text = coinMargetModel.current_price.convertToKRWCurrency
        
        if coinMargetModel.price_change_percentage_24h > 0 {
            labelStackView.priceChagingRateLabel.textColor = .customRed
            labelStackView.priceChagingRateLabel.text = "+" + coinMargetModel.price_change_percentage_24h.moveDecimalPointUtilTwoDecimalPlaces + "%"
        } else {
            labelStackView.priceChagingRateLabel.textColor = .customBlue
            labelStackView.priceChagingRateLabel.text = coinMargetModel.price_change_percentage_24h.moveDecimalPointUtilTwoDecimalPlaces + "%"
        }
        
        priceStackViewContainerView.highPriceStackView.topPart.priceLabel.text = coinMargetModel.high_24h.convertToKRWCurrency
        priceStackViewContainerView.highPriceStackView.bottomPart.priceLabel.text = coinMargetModel.ath.convertToKRWCurrency
    
        priceStackViewContainerView.lowPriceStackView.topPart.priceLabel.text = coinMargetModel.low_24h.convertToKRWCurrency
        priceStackViewContainerView.lowPriceStackView.bottomPart.priceLabel.text = coinMargetModel.atl.convertToKRWCurrency
        
        lastUpdatedLabel.text = coinMargetModel.last_updated.convertToLastUpdatedFormat + " 업데이트"
    }
    
    func configureUserEvents() {
        
    }
    
    private func bindings() {
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
    
    private func configureLineChartViewUI() {
        guard let coinMargetModel = coinMargetModel else { return }

        var entry: [ChartDataEntry] = []
        
        for (index, price) in coinMargetModel.sparkline_in_7d.price.enumerated() {
            entry.append(.init(x: Double(index), y: price))
        }
        
        let set = LineChartDataSet(entries: entry)
        
        set.drawCirclesEnabled = false
        set.mode = .cubicBezier
        set.lineWidth = 3
        set.setColor(.customPurple)
        set.drawHorizontalHighlightIndicatorEnabled = false
        set.highlightColor = .customPurple
        
        let gradientColors: [CGColor] = [
            UIColor.customPurple.cgColor,
            UIColor.customWhite.cgColor
        ]
        let gradient =  CGGradient(colorsSpace: nil, colors: gradientColors as CFArray, locations: nil)!
        set.fill = LinearGradientFill(gradient: gradient, angle: 270)
        set.fillAlpha = 1
        set.drawFilledEnabled = true
        
        // 차트 뷰에 차트 데이터 추가
        let data = LineChartData(dataSet: set)
        lineChartView.data = data
        lineChartView.pinchZoomEnabled = true
    }
}
