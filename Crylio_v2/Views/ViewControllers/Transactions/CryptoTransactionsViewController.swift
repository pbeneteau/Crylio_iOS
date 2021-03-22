//
//  CryptoHistoryViewController.swift
//  Crylio_v2
//
//  Created by Paul Bénéteau on 08/02/2021.
//

import UIKit


struct Transaction {
    
    var transactionType: TransactionType
    var exchange: String
    var amount: Float
    var dateString: String
    var worth: Float
}

enum TransactionType: String {
    
    case sell = "Sell"
    case buy = "Buy"
    case transferIn = "Transfer in"
    case transferOut = "Transfer out"
}


class CryptoTransactionsViewController: UIViewController {
    
    
    lazy var tableView = UITableView()
    let cellId = "TransactionCell"
    var refreshControl = UIRefreshControl()
    
    var transactions = [Transaction]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.isHidden = true
        
        
        transactions.append(Transaction(transactionType: .buy, exchange: "Binance", amount: 2.4, dateString: "Dec 30, 2020 06:30 pm", worth: 91401.41))
        
        transactions.append(Transaction(transactionType: .sell, exchange: "Binance", amount: 2.4, dateString: "Dec 30, 2020 06:30 pm", worth: 91401.41))
        
        transactions.append(Transaction(transactionType: .transferIn, exchange: "Binance", amount: 2.4, dateString: "Dec 30, 2020 06:30 pm", worth: 91401.41))
        
        
        commonInit()
        
        tableView.reloadData()
        
    }
    
    
    private func commonInit() {
        
        view.backgroundColor = .clear
        
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        
        tableView.rowHeight = 64
        tableView.register(CryptoTransactionCell.self, forCellReuseIdentifier: cellId)
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        
        view.addSubview(tableView)
        tableView.addSubview(refreshControl)
    }
    
    func updateInsets(menuMaxY: CGFloat) {
        
        tableView.contentInset = UIEdgeInsets(top: menuMaxY, left: 0, bottom: 0, right: 0)
        tableView.scrollIndicatorInsets = UIEdgeInsets(top: menuMaxY-20, left: 0, bottom: 0, right: 0)
    }
    
    @objc func refresh() {
        
        print("Refreshing data...")
        
        let seconds = 4.0
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
            self.refreshControl.endRefreshing()
        }
    }
    
    override func updateViewConstraints() {
        
        tableView.snp.makeConstraints { make in
            make.left.top.bottom.right.equalToSuperview()
            make.width.height.equalToSuperview()
        }
        
        super.updateViewConstraints()
    }
    
}

extension CryptoTransactionsViewController: UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return transactions.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? CryptoTransactionCell  else {
            fatalError("The dequeued cell is not an instance of HomeTableViewCell.")
        }
        
        cell.transaction = transactions[indexPath.row]
                
        return cell
    }
    
}
