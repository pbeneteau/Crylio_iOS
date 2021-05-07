//
//  DistributionView.swift
//  Crylio_v2
//
//  Created by Paul Bénéteau on 15/03/2021.
//

import UIKit

class DistributionView: UIView {
    
    lazy var title = UILabel()
    
    lazy var backgroundBox = UIView()
    
    lazy var statesTitle = UILabel()

    var statesBar: DistributionBar!
    
    lazy var stackedIcon = UIImageView()
    lazy var onTradeIcon = UIImageView()
    lazy var onOrderIcon = UIImageView()
    lazy var availableIcon = UIImageView()
    
    lazy var stackedlabel = UILabel()
    lazy var onTradelabel = UILabel()
    lazy var onOrderlabel = UILabel()
    lazy var availablelabel = UILabel()


    override init(frame: CGRect) {
        super.init(frame: frame)
        
        commonInit()
    }
    
    init(onOrder: Float,
         onTrade: Float,
         stacked: Float,
         available: Float) {
        
        super.init(frame: CGRect.zero)
        
        statesBar = DistributionBar(values: [BarValue(percent: onTrade, color: .systemRed, name: "On Trade"),
                                             BarValue(percent: onOrder, color: .systemGreen, name: "On Order"),
                                             BarValue(percent: stacked, color: .systemBlue, name: "Stacked"),
                                             BarValue(percent: available, color: .systemGray, name: "Available")])
           
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        commonInit()
    }
    
    
    private func commonInit() {
        
        backgroundColor = .clear
        backgroundBox.backgroundColor = AppColors.background.secondary
        
        backgroundBox.layer.cornerRadius = 7
        
        title.text = "Distribution"
        statesTitle.text = "States"
        
        title.font = .systemFont(ofSize: 20, weight: .bold)
        title.textColor = .label
        
        stackedlabel.text = "Stacked"
        onTradelabel.text = "On Trade"
        onOrderlabel.text = "On Order"
        availablelabel.text = "Available"
        
        stackedlabel.font = .systemFont(ofSize: 13)
        onTradelabel.font = .systemFont(ofSize: 13)
        onOrderlabel.font = .systemFont(ofSize: 13)
        availablelabel.font = .systemFont(ofSize: 13)
        
        stackedlabel.textColor = .systemGray
        onTradelabel.textColor = .systemGray
        onOrderlabel.textColor = .systemGray
        availablelabel.textColor = .systemGray
        
        stackedIcon.image = UIImage(named: "stackedIcon")
        onTradeIcon.image = UIImage(named: "onTradeIcon")
        onOrderIcon.image = UIImage(named: "onOrderIcon")
        availableIcon.image = UIImage(named: "availableIcon")
        
                
        addSubview(title)
        addSubview(backgroundBox)
        backgroundBox.addSubview(statesTitle)
        backgroundBox.addSubview(statesBar)
        
        backgroundBox.addSubview(stackedIcon)
        backgroundBox.addSubview(onTradeIcon)
        backgroundBox.addSubview(onOrderIcon)
        backgroundBox.addSubview(availableIcon)

        backgroundBox.addSubview(stackedlabel)
        backgroundBox.addSubview(onTradelabel)
        backgroundBox.addSubview(onOrderlabel)
        backgroundBox.addSubview(availablelabel)


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
            make.top.equalTo(title.snp.bottom).offset(15)
            make.width.equalToSuperview().offset(-32)
            make.bottom.equalToSuperview().offset(-10)
        }
        
        statesTitle.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.top.equalToSuperview().offset(16)
            make.height.equalTo(20)
            make.width.equalTo(statesTitle.intrinsicContentSize.width)
        }
        
        statesBar.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.top.equalTo(statesTitle.snp.bottom).offset(10)
            make.height.equalTo(20)
            make.right.equalToSuperview().offset(-16)
        }
        
        onTradeIcon.snp.makeConstraints { make in
            make.left.equalTo(statesBar)
            make.top.equalTo(statesBar.snp.bottom).offset(10)
            make.width.height.equalTo(25)
        }
        onTradelabel.snp.makeConstraints { make in
            make.left.equalTo(onTradeIcon.snp.right).offset(10)
            make.centerY.equalTo(onTradeIcon)
            make.width.equalTo(70)
            make.height.equalTo(20)
        }
        
        onOrderIcon.snp.makeConstraints { make in
            make.left.equalTo(onTradelabel.snp.right).offset(20)
            make.top.equalTo(statesBar.snp.bottom).offset(10)
            make.width.height.equalTo(25)
        }
        onOrderlabel.snp.makeConstraints { make in
            make.left.equalTo(onOrderIcon.snp.right).offset(10)
            make.centerY.equalTo(onOrderIcon)
            make.width.equalTo(70)
            make.height.equalTo(20)
        }
        
        stackedIcon.snp.makeConstraints { make in
            make.left.equalTo(onOrderlabel.snp.right).offset(20)
            make.top.equalTo(statesBar.snp.bottom).offset(10)
            make.width.height.equalTo(25)
        }
        stackedlabel.snp.makeConstraints { make in
            make.left.equalTo(stackedIcon.snp.right).offset(10)
            make.centerY.equalTo(stackedIcon)
            make.width.equalTo(70)
            make.height.equalTo(20)
        }
        
        availableIcon.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.top.equalTo(onOrderIcon.snp.bottom).offset(10)
            make.width.height.equalTo(25)
        }
        availablelabel.snp.makeConstraints { make in
            make.left.equalTo(availableIcon.snp.right).offset(10)
            make.centerY.equalTo(availableIcon)
            make.width.equalTo(70)
            make.height.equalTo(20)
        }
        
        
        
        super.updateConstraints()
        
    }
    

}
