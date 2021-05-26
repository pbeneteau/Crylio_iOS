//
//  AddTransactionViewController.swift
//  Crylio_v2
//
//  Created by Paul Bénéteau on 25/05/2021.
//

import UIKit


struct Field {
    
    var type: FieldType
    var title: String
    var placeholder: String
    var prefix: String! = ""
    var suffix: String! = ""
    var value: String?
    var keyboardType: UIKeyboardType! = .default
    var suggestions: [String]?
    
    enum FieldType {
        
        case exchange
        case pair
        case price
        case quantity
        case fees
        case date
    }
}



class AddTransactionViewController: UIViewController {
    
    lazy var transactionTypePicker = UISegmentedControl(items: ["Long", "short", "Transfer"])
    lazy var tableView = UITableView()
    lazy var addTransactionButton = RoundCornerButton()
    
    private var fields = [Field]()
    
    var crypto: Cryptocurrency! {
        didSet {
            updateValues()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = AppColors.background.primary
        
        transactionTypePicker.selectedSegmentTintColor = .systemGreen
        transactionTypePicker.selectedSegmentIndex = 0
        transactionTypePicker.addTarget(self, action: #selector(segmentedControlValueChanged(_:)), for: .valueChanged)
        //transactionTypePicker.backgroundColor = AppColors.background.tertiary
        transactionTypePicker.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: .selected)
        transactionTypePicker.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: AppColors.label.secondary], for: .normal)

        
        tableView.backgroundColor = AppColors.background.primary
        tableView.register(AddTransactionTableViewCell.self, forCellReuseIdentifier: AddTransactionTableViewCell.reuseId)
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        tableView.keyboardDismissMode = .onDrag
        
        fields.append(Field(type: .exchange, title: "Exchange", placeholder: "Binance", suggestions: ["Binance", "Bitfinex", "Bittrex"]))
        fields.append(Field(type: .pair, title: "Trading Pair", placeholder: "", prefix: "BTC /", value: "USDT"))
        fields.append(Field(type: .price, title: "Per coin", placeholder: String(0), suffix: " USDT", keyboardType: .decimalPad))
        fields.append(Field(type: .quantity, title: "Quantity", placeholder: String(0), suffix: " BTC", keyboardType: .decimalPad))
        fields.append(Field(type: .fees, title: "Fees", placeholder: String(0), suffix: " USDT", keyboardType: .decimalPad))
        fields.append(Field(type: .date, title: "Date", placeholder: "23 May, 2021", value: "23 May, 2021"))
        
        tableView.reloadData()
        
        view.addSubview(transactionTypePicker)
        view.addSubview(tableView)
        view.addSubview(addTransactionButton)
        view.bringSubviewToFront(addTransactionButton)
        
        updateViewConstraints()
        
        for s in transactionTypePicker.subviews {
            print(s.backgroundColor?.rgb())
        }
    }
    
    private func updateValues() {
        
        tableView.reloadData()
    }
    
    @objc private func segmentedControlValueChanged(_ sender: UISegmentedControl) {
        
            switch sender.selectedSegmentIndex {
            case 0: sender.selectedSegmentTintColor = .systemGreen
            case 1: sender.selectedSegmentTintColor = .systemRed
            case 2: sender.selectedSegmentTintColor = .systemGray
            default:
                return
            }
        
        print(sender.selectedSegmentIndex)
    }

}


// MARK: - Table view delegate and datasource

extension AddTransactionViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fields.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let cell = tableView.dequeueReusableCell(withIdentifier: AddTransactionTableViewCell.reuseId, for: indexPath) as? AddTransactionTableViewCell  else {
            fatalError("The dequeued cell is not an instance of AddTransactionTableViewCell.")
        }
        
        cell.field = fields[indexPath.row]
                
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
    
    
}


// MARK: - Constraints

extension AddTransactionViewController {
    
    override func updateViewConstraints() {
        
        transactionTypePicker.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.top.equalTo(90)
            make.right.equalToSuperview().inset(16)
            make.height.equalTo(30)
        }
        
        tableView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.top.equalTo(transactionTypePicker.snp.bottom).offset(20)
            make.right.equalToSuperview().inset(16)
            make.bottom.equalTo(addTransactionButton.snp.top).inset(20)
        }
        
        addTransactionButton.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.bottom.equalToSuperview().inset(80)
            make.right.equalToSuperview().inset(16)
            make.height.equalTo(52)
        }
        
        super.updateViewConstraints()
    }
}
