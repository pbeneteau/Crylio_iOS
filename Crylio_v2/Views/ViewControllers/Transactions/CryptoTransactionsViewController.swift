//
//  CryptoHistoryViewController.swift
//  Crylio_v2
//
//  Created by Paul Bénéteau on 08/02/2021.
//

import UIKit


struct Transaction {
    
    var asset: String
    var transactionType: TransactionType
    var exchange: String
    var amount: Float
    var time: Date
    var worth: Float
}

enum TransactionType: String {
    
    case marketSell = "Market Sell"
    case marketBuy = "Market Buy"
    case limitSell = "Limit Sell"
    case limitBuy = "Limit Buy"
    case transferIn = "Transfer in"
    case transferOut = "Transfer out"
}

struct TransactionsMonthSection {
    
    var month: Date
    var transactions: [Transaction]
    
    static func group(transactions : [Transaction]) -> [TransactionsMonthSection] {
        
        let groups = Dictionary(grouping: transactions) { (transaction) -> Date in
            return transaction.time.getFirstDayOfMonth()
        }
        return groups.map(TransactionsMonthSection.init(month:transactions:))
    }
}


class CryptoTransactionsViewController: UIViewController {
    
    
    lazy var tableView = UITableView()
    var refreshControl = UIRefreshControl()
    
    var blurredHeaderViewAlpha: CGFloat = 0.0
    
    var sections = [TransactionsMonthSection]()
    var transactions = [Transaction]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.isHidden = true
        
        tableView.delegate = self
        tableView.dataSource = self
        
        view.backgroundColor = .clear
        
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        
        tableView.backgroundColor = .systemBackground
        
        tableView.rowHeight = 74
        tableView.sectionHeaderHeight = 50
        
        tableView.register(CryptoTransactionCell.self, forCellReuseIdentifier: CryptoTransactionCell.reuseId)
        tableView.register(TransactionsHeaderView.self, forHeaderFooterViewReuseIdentifier: TransactionsHeaderView.reuseId)
        
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 32, bottom: 0, right: 16)
        tableView.tableFooterView = UIView()
        
        view.addSubview(tableView)
        tableView.addSubview(refreshControl)
        
        data()
    }
    
    private func data() {
        
        let item1 = Transaction(asset: "BTC", transactionType: .marketBuy, exchange: "Binance", amount: 0.48591, time: Date(), worth: 9401.41)
        let item2 = Transaction(asset: "BTC", transactionType: .marketSell, exchange: "Bitfinex", amount: 0.94114, time: Date(), worth: 41491.67)
        
        var dateComponent = DateComponents()
        
        dateComponent.month = 1
        let futureDate = Calendar.current.date(byAdding: dateComponent, to: Date())
        
        let item3 = Transaction(asset: "BTC", transactionType: .transferIn, exchange: "Coinbase", amount: 0.24123, time: futureDate!, worth: 5141.10)
        
        transactions.append(item1)
        transactions.append(item2)
        transactions.append(item3)
        
        sections = TransactionsMonthSection.group(transactions: transactions)
        sections.sort { (lhs, rhs) in lhs.month < rhs.month }
        
        tableView.reloadData()
        
    }
    
    func updateInsets(menuMaxY: CGFloat) {
        
        tableView.contentInset = UIEdgeInsets(top: menuMaxY, left: 0, bottom: 0, right: 0)
        tableView.scrollIndicatorInsets = UIEdgeInsets(top: menuMaxY-20, left: 0, bottom: 0, right: 0)
        tableView.contentOffset = CGPoint(x: 0, y: -menuMaxY)
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

extension CryptoTransactionsViewController: UIScrollViewDelegate, UITableViewDelegate, UITableViewDataSource {
    
    
    // SECTION
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        print("numberOfSections")
        return self.sections.count
    }
    
//    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        return "Test"
//    }
//
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {

        print("heightForHeaderInSection")
        return 50
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {

        print("heightForFooterInSection")
        return 20
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        print("viewForHeaderInSection")

        
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: TransactionsHeaderView.reuseId) as! TransactionsHeaderView
        
        return headerView
    }
    
    
    // CELLS
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return sections[section].transactions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CryptoTransactionCell.reuseId, for: indexPath) as? CryptoTransactionCell  else {
            fatalError("The dequeued cell is not an instance of HomeTableViewCell.")
        }
        
        if indexPath.row < transactions.count {
            
            cell.transaction = sections[indexPath.section].transactions[indexPath.row]
        }
        
        if indexPath.row == 0 {
            cell.bgView.layer.cornerRadius = 7
            cell.bgView.layer.masksToBounds = true
            cell.bgView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        } else if indexPath.row == tableView.numberOfRows(inSection: indexPath.section)-1 {
            cell.bgView.layer.cornerRadius = 7
            cell.bgView.layer.masksToBounds = true
            cell.bgView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        } else {
            cell.bgView.layer.cornerRadius = 0
        }
        
        cell.selectionStyle = .none
        
        return cell
    }
    

    
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//
//        let header = UIView(frame: CGRect(origin: .zero, size: CGSize(width: UIScreen.main.bounds.width, height: 50.0)))
//        let dateLabel = UILabel()
//
//        dateLabel.font = .systemFont(ofSize: 16, weight: .semibold)
//
//        let date = sections[section].month
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "MMMM yyyy"
//
//        dateLabel.text = dateFormatter.string(from: date)
//
//        header.backgroundColor = .systemRed
//
//        header.addSubview(dateLabel)
//
//        dateLabel.snp.makeConstraints { make in
//            make.left.top.equalTo(16)
//            make.width.equalTo(dateLabel.intrinsicContentSize.width)
//            make.height.equalTo(20)
//        }
//
//        print(12345)
//        return header
//    }
    


}
