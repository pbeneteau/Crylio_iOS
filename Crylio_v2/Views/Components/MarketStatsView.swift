//
//  MarketStatsView.swift
//  Crylio_v2
//
//  Created by Paul Bénéteau on 05/02/2021.
//

import UIKit

class MarketStatsView: UIView {
    
    lazy var title = UILabel()
    
    lazy var backgroundBox = RoundedCornersView()
    
    lazy var volume24Title = UILabel()
    lazy var volume24 = UILabel()
    lazy var volume24Change = UILabel()
    lazy var marketCapTitle = UILabel()
    lazy var marketCap = UILabel()
    lazy var marketCapChange = UILabel()
    lazy var availableSupplyTitle = UILabel()
    lazy var availableSupply = UILabel()
    lazy var availableSupplyChange = UILabel()
    lazy var totalSupplyTitle = UILabel()
    lazy var totalSupply = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        commonInit()
    }
    
    init(volume24: Float,
         volume24Change: Float,
         marketCap: Float,
         marketCapChange: Float,
         availableSupply: Float,
         availableSupplyChange: Float,
         totalSupply: Float) {
        
        super.init(frame: CGRect.zero)
        
        self.volume24.text = "\(volume24)"
        self.volume24Change.text = "\(volume24Change) %"
        self.marketCap.text = "\(marketCap)"
        self.marketCapChange.text = "\(marketCapChange) %"
        self.availableSupply.text = "\(availableSupply)"
        self.availableSupplyChange.text = "\(availableSupplyChange) %"
        self.totalSupply.text = "\(totalSupply)"
                
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        commonInit()
    }
    
    private func commonInit() {
        
        backgroundColor = .clear
        
        backgroundBox.layer.cornerRadius = 10
        backgroundBox.backgroundColor = .systemGray6
        
        title.text = "Market Stats"
        
        volume24Title.text = "Volume 24h"
        marketCapTitle.text = "Market Cap"
        availableSupplyTitle.text = "Available Supply"
        totalSupplyTitle.text = "Total Supply"
        
        title.font = .systemFont(ofSize: 20, weight: .bold)
        
        volume24Title.font = .systemFont(ofSize: 13)
        volume24.font = .systemFont(ofSize: 17, weight: .medium)
        volume24Change.font = .systemFont(ofSize: 17)
        marketCapTitle.font = .systemFont(ofSize: 13)
        marketCap.font = .systemFont(ofSize: 17, weight: .medium)
        marketCapChange.font = .systemFont(ofSize: 17)
        availableSupplyTitle.font = .systemFont(ofSize: 13)
        availableSupply.font = .systemFont(ofSize: 17, weight: .medium)
        availableSupplyChange.font = .systemFont(ofSize: 17)
        totalSupplyTitle.font = .systemFont(ofSize: 13)
        totalSupply.font = .systemFont(ofSize: 17, weight: .medium)
        
        title.textColor = .label
        
        volume24Title.textColor = .systemGray
        volume24.textColor = .label
        volume24Change.textColor = .systemGreen
        marketCapTitle.textColor = .systemGray
        marketCap.textColor = .label
        marketCapChange.textColor = .systemGreen
        availableSupplyTitle.textColor = .systemGray
        availableSupply.textColor = .label
        availableSupplyChange.textColor = .systemGreen
        totalSupplyTitle.textColor = .systemGray
        totalSupply.textColor = .label
        
        addSubview(title)
        addSubview(backgroundBox)
        
        backgroundBox.addSubview(volume24Title)
        backgroundBox.addSubview(volume24)
        backgroundBox.addSubview(volume24Change)
        backgroundBox.addSubview(marketCapTitle)
        backgroundBox.addSubview(marketCap)
        backgroundBox.addSubview(marketCapChange)
        backgroundBox.addSubview(availableSupplyTitle)
        backgroundBox.addSubview(availableSupply)
        backgroundBox.addSubview(availableSupplyChange)
        backgroundBox.addSubview(totalSupplyTitle)
        backgroundBox.addSubview(totalSupply)
        
        backgroundBox.translatesAutoresizingMaskIntoConstraints = false
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    override func updateConstraints() {
        
        title.snp.makeConstraints { make in
            make.width.equalTo(200)
            make.left.equalTo(16)
            make.top.equalToSuperview()
            make.height.equalTo(22)
        }
        
        backgroundBox.snp.makeConstraints { make in
            make.left.equalTo(16)
            make.bottom.equalToSuperview()
            make.width.height.equalToSuperview().offset(-32)
        }
        
        volume24Title.snp.makeConstraints { make in
            make.left.equalTo(16)
            make.top.equalTo(16)
            make.width.equalTo(150)
            make.height.equalTo(16)
        }
        volume24.snp.makeConstraints { make in
            make.left.equalTo(16)
            make.top.equalTo(volume24Title.snp.bottom).offset(5)
            make.width.equalTo(150)
            make.height.equalTo(20)
        }
        volume24Change.snp.makeConstraints { make in
            make.left.equalTo(16)
            make.top.equalTo(volume24.snp.bottom).offset(5)
            make.width.equalTo(150)
            make.height.equalTo(20)
        }
        
        availableSupplyTitle.snp.makeConstraints { make in
            make.left.equalTo(16)
            make.top.equalTo(volume24Change.snp.bottom).offset(10)
            make.width.equalTo(150)
            make.height.equalTo(16)
        }
        availableSupply.snp.makeConstraints { make in
            make.left.equalTo(16)
            make.top.equalTo(availableSupplyTitle.snp.bottom).offset(5)
            make.width.equalTo(150)
            make.height.equalTo(20)
        }
        availableSupplyChange.snp.makeConstraints { make in
            make.left.equalTo(16)
            make.top.equalTo(availableSupply.snp.bottom).offset(5)
            make.width.equalTo(150)
            make.height.equalTo(20)
        }
        
        marketCapTitle.snp.makeConstraints { make in
            make.left.equalTo(snp.centerX).offset(16)
            make.top.equalTo(16)
            make.right.equalToSuperview().offset(-16)
            make.height.equalTo(16)
        }
        marketCap.snp.makeConstraints { make in
            make.left.equalTo(snp.centerX).offset(16)
            make.top.equalTo(marketCapTitle.snp.bottom).offset(5)
            make.right.equalToSuperview().offset(-16)
            make.height.equalTo(20)
        }
        marketCapChange.snp.makeConstraints { make in
            make.left.equalTo(snp.centerX).offset(16)
            make.top.equalTo(marketCap.snp.bottom).offset(5)
            make.right.equalToSuperview().offset(-16)
            make.height.equalTo(20)
        }
        
        totalSupplyTitle.snp.makeConstraints { make in
            make.left.equalTo(snp.centerX).offset(16)
            make.top.equalTo(marketCapChange.snp.bottom).offset(10)
            make.right.equalToSuperview().offset(-16)
            make.height.equalTo(16)
        }
        totalSupply.snp.makeConstraints { make in
            make.left.equalTo(snp.centerX).offset(16)
            make.top.equalTo(totalSupplyTitle.snp.bottom).offset(5)
            make.right.equalToSuperview().offset(-16)
            make.height.equalTo(20)
        }
        
        super.updateConstraints()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // Manually set subview frames here
    }
}
