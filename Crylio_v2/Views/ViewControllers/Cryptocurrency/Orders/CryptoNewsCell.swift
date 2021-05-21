//
//  CryptoOrderCell.swift
//  Crylio_v2
//
//  Created by Paul Bénéteau on 30/03/2021.
//

import UIKit
import Kingfisher


class CryptoNewsCell: UITableViewCell {
    
    static let reuseId = "FeedCell"
    
    lazy var contentBox = UIView()
    lazy var typeImageBox = RoundedCornersView()
    lazy var typeImageView = UIImageView()
    lazy var autorLabel = UILabel()
    lazy var separatorView = CircleView()
    lazy var timeLabel = UILabel()
    lazy var moreButton = UIButton()
    lazy var titleLabel = UILabel()
    lazy var newsImageView = UIImageView()
    
    var news: News! {
        didSet {
            initValues()
        }
    }
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        
        fatalError("init(coder:) has not been implemented")
    }

    private func commonInit() {
        
        selectionStyle = .none
        
        backgroundColor = .clear
        contentView.backgroundColor = .clear
        
        typeImageBox.layer.cornerRadius = 4
        typeImageBox.backgroundColor = AppColors.background.secondary
                
        autorLabel.font = .systemFont(ofSize: 15)
        autorLabel.textColor = AppColors.label.secondary
        
        separatorView.backgroundColor = AppColors.label.secondary
        
        timeLabel.font = .systemFont(ofSize: 15)
        timeLabel.textColor = AppColors.label.secondary
        
        titleLabel.font = .systemFont(ofSize: 17, weight: .regular)
        titleLabel.numberOfLines = 0
        
        newsImageView.layer.cornerRadius = 10
        newsImageView.clipsToBounds = true
        newsImageView.backgroundColor = AppColors.background.tertiary
        newsImageView.contentMode = .scaleAspectFill
        
        let moreIcon = UIImage(named: "moreIcon")?.withRenderingMode(.alwaysTemplate)
        moreButton.setImage(moreIcon, for: .normal)
        moreButton.tintColor = AppColors.label.secondary
        
        contentView.addSubview(contentBox)
        contentBox.addSubview(typeImageBox)
        typeImageBox.addSubview(typeImageView)
        contentBox.addSubview(autorLabel)
        contentBox.addSubview(separatorView)
        contentBox.addSubview(timeLabel)
        contentBox.addSubview(moreButton)
        contentBox.addSubview(titleLabel)
        contentBox.addSubview(newsImageView)

    }
    
    func initValues() {
        
        typeImageView.image = UIImage(named: news.type.rawValue + "Icon")?.withRenderingMode(.alwaysTemplate)
        titleLabel.text = news.title
        autorLabel.text = news.autor
        timeLabel.text = news.time.timeAgoDisplay()
        
        if news.type == .web {
            typeImageView.tintColor = AppColors.label.primary
            titleLabel.font = .systemFont(ofSize: 17, weight: .bold)
        }
        
        setNeedsUpdateConstraints()
        
        if let url =  news.imageURL {
            setImage(with: url)
        }
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        
        super.setSelected(selected, animated: animated)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
    }
    
}


extension CryptoNewsCell {
    
    private func loadImage(_ url: String) {
        
        let url = URL(string: url)
        let processor = ResizingImageProcessor(referenceSize: CGSize(width: 363, height: 200), mode: .aspectFill)
        
        newsImageView.kf.indicatorType = .activity
        
        newsImageView.kf.setImage(
            with: url,
            options: [
                .processor(processor),
                .scaleFactor(UIScreen.main.scale),
                .transition(.fade(0.3)),
                .cacheOriginalImage
            ])
        {
            result in
            switch result {
            case .success(let success):
                print("\(success.image)")
            case .failure(let error):
                print("Error Downloading news image: \(error.localizedDescription)")
            }
        }
    }
    
    private func setImage(with url: String) {
        
        let cache = ImageCache.default
        
        if cache.isCached(forKey: url) {
            
            cache.retrieveImage(forKey: "cacheKey") { result in
                switch result {
                case .success(let value):
                    print("Found cached news image")
                    switch value {
                    case .none:
                        self.loadImage(url)
                    case .disk:
                        DispatchQueue.main.async { self.newsImageView.image = value.image }
                    case .memory:
                        DispatchQueue.main.async { self.newsImageView.image = value.image }
                    }
                case .failure(let error):
                    print(error)
                }
            }
        } else {
            self.loadImage(url)
        }
    }

}


// MARKS: Constraints

extension CryptoNewsCell {
    
    override func updateConstraints() {
        
        contentBox.snp.makeConstraints { make in
            make.left.top.equalToSuperview().offset(16)
            make.right.bottom.equalToSuperview().inset(16)
        }
        
        typeImageBox.snp.makeConstraints { make in
            make.left.top.equalToSuperview()
            make.width.height.equalTo(25)
        }
        
        typeImageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.height.equalTo(17)
        }
        
        autorLabel.snp.makeConstraints { make in
            make.left.equalTo(typeImageBox.snp.right).offset(10)
            make.centerY.equalTo(typeImageBox)
            make.width.equalTo(autorLabel.intrinsicContentSize.width)
            make.height.equalTo(16)
        }
        
        separatorView.snp.makeConstraints { make in
            make.left.equalTo(autorLabel.snp.right).offset(5)
            make.centerY.equalTo(typeImageBox)
            make.width.height.equalTo(3)
        }
        
        timeLabel.snp.makeConstraints { make in
            make.left.equalTo(separatorView.snp.right).offset(5)
            make.centerY.equalTo(typeImageBox)
            make.width.equalTo(autorLabel.intrinsicContentSize.width)
            make.height.equalTo(16)
        }
        
        moreButton.snp.makeConstraints { make in
            make.right.equalToSuperview()
            make.centerY.equalTo(typeImageBox)
            make.width.height.equalTo(25)
        }
        
        if news.imageURL != nil {
            
            titleLabel.snp.makeConstraints { make in
                make.left.equalTo(autorLabel)
                make.right.equalToSuperview()
                make.top.equalTo(typeImageBox.snp.bottom).offset(5)
            }
            
            newsImageView.snp.makeConstraints { make in
                make.left.equalTo(autorLabel)
                make.right.equalToSuperview()
                make.top.equalTo(titleLabel.snp.bottom).offset(15)
                make.height.equalTo(200)
                make.bottom.equalToSuperview().priority(100)
            }
        } else {
            
            titleLabel.snp.makeConstraints { make in
                make.left.equalTo(autorLabel)
                make.right.equalToSuperview()
                make.top.equalTo(typeImageBox.snp.bottom).offset(5)
                make.bottom.equalToSuperview().priority(100)
            }
        }
        
        super.updateConstraints()
    }

}

