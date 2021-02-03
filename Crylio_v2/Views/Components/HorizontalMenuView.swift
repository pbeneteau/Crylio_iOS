//
//  HorizontalMenuView.swift
//  Crylio_v2
//
//  Created by Paul Bénéteau on 30/01/2021.
//

import UIKit


protocol HorizontalMenuProtocol : NSObjectProtocol {
    func menuButtonTapped(sender: UIButton!)
}

class HorizontalMenu: RoundedCornersView {
    
    weak var delegate: HorizontalMenuProtocol? = nil
    
    var items = [String]()
    
    lazy var selectedButtonView = RoundedCornersView()
    
    var buttons = [UIButton]()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        commonInit()
    }
    
    init(items: [String]) {
        super.init(frame: CGRect.zero)
        
        self.items = items
        
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        commonInit()
    }
    
    private func commonInit() {
        
        layer.cornerRadius = 10
        
        selectedButtonView.backgroundColor = .systemGray6
        selectedButtonView.flx_smoothCorners = true
        selectedButtonView.layer.cornerRadius = 10
                
        addSubview(selectedButtonView)
        
        for (index, item) in items.enumerated() {
            let button = UIButton()
            button.setTitle(item, for: .normal)
            button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .medium)
            button.tag = index
            button.tintColor = .label
            button.setTitleColor(.label, for: .selected)
            button.setTitleColor(.systemGray2, for: .normal)
            
            button.addTarget(self, action: #selector(self.buttonTapped(sender:)), for: .touchUpInside)
            
            addSubview(button)
            buttons.append(button)
        }
        
        buttons[0].isSelected = true
        
        self.backgroundColor = .clear
    }
    
    @objc func buttonTapped(sender: UIButton!) {
        setSelectedButton(tag: sender.tag)
        self.delegate?.menuButtonTapped(sender: sender)
    }
    
    override func updateConstraints() {
        
        //set subview constraints here
        
        setButtonsConstraints()
        
        selectedButtonView.snp.makeConstraints { make in
            make.edges.equalTo(buttons[0])
        }
        
        super.updateConstraints()
    }
    
    func setButtonsConstraints() {
        
        for (index, button) in buttons.enumerated() {
            
            if index == 0 {
                button.snp.makeConstraints { make in
                    make.top.bottom.equalToSuperview()
                    make.left.equalToSuperview()
                    make.width.equalTo(button.intrinsicContentSize.width + 30)
                }
            } else {
                button.snp.makeConstraints { make in
                    make.top.bottom.equalToSuperview()
                    make.left.equalTo(buttons[index-1].snp.right)
                    make.width.equalTo(button.intrinsicContentSize.width + 30)
                }
            }
        }
    }
    
    func setSelectedButton(tag: Int) {
        
        for (index, button) in buttons.enumerated() {
            if index != tag {
                button.isSelected = false
            } else {
                button.isSelected = true
            }
        }
       
        UIView.animate(withDuration: 0.3, delay:0, options: .beginFromCurrentState) {
            self.selectedButtonView.snp.remakeConstraints { make in
                make.edges.equalTo(self.buttons[tag])
            }
            self.layoutIfNeeded()
        }
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        //manually set subview frames here
    }
    
    func widthForView(text:String, height:CGFloat) -> CGFloat{
        let label:UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: CGFloat.greatestFiniteMagnitude, height: height))
       label.numberOfLines = 0
       label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.font = .systemFont(ofSize: 14, weight: .medium)
       label.text = text

       label.sizeToFit()
       return label.frame.height
   }

    
}

