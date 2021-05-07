//
//  CryptoOrdersViewController.swift
//  Crylio_v2
//
//  Created by Paul Bénéteau on 08/02/2021.
//

import UIKit


struct Order {
    var asset: String
    var orderType: OrderType
    var exchange: String
    var amountExecuted: Float
    var amount: Float
    var dateString: String
    var worth: Float
    var status: OrderStatus
}


enum OrderType: String {
    
    case marketSell = "Market Sell"
    case marketBuy = "Market Buy"
    case limitBuy = "Limit Buy"
    case limitSell = "Limit Sell"
}


enum OrderStatus: String {
    
    case filled = "Filled"
    case unfilled = "Unfilled"
    case canceled = "Canceled"
}

class CryptoOrdersViewController: BaseViewController {
    
    lazy var tableView = UITableView(frame: CGRect.zero, style: .plain)

    let cellId = "OrderCell"
    var refreshControl = UIRefreshControl()
    
    weak var scrollViewDelegate: ScrollViewDidScrollDelegate?
    
    var blurredHeaderViewAlpha: CGFloat = 0.0

    var orders = [Order]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.isHidden = true
        
        orders.append(Order(asset: "BTC", orderType: .marketBuy, exchange: "Binance", amountExecuted: 2.4, amount: 2.4, dateString: "Dec 30, 2020 06:30 pm", worth: 91401.41, status: .filled))
        orders.append(Order(asset: "BTC", orderType: .marketSell, exchange: "Binance", amountExecuted: 2.4, amount: 2.4, dateString: "Dec 30, 2020 06:30 pm", worth: 91401.41, status: .canceled))
        orders.append(Order(asset: "BTC", orderType: .limitBuy, exchange: "Binance", amountExecuted: 2.4, amount: 2.4, dateString: "Dec 30, 2020 06:30 pm", worth: 91401.41, status: .filled))
        orders.append(Order(asset: "BTC", orderType: .limitSell, exchange: "Binance", amountExecuted: 2.4, amount: 2.4, dateString: "Dec 30, 2020 06:30 pm", worth: 91401.41, status: .unfilled))

        commonInit()
        
        tableView.reloadData()
    }
    
    private func commonInit() {
                
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        
        tableView.backgroundColor = .clear
        
        tableView.rowHeight = 90
        
        tableView.register(CryptoOrderCell.self, forCellReuseIdentifier: cellId)
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.layoutMargins.top = 0
        tableView.contentInsetAdjustmentBehavior = .never
        
        tableView.tableFooterView = UIView() // Eliminate extra separators below UITableView
        
        view.addSubview(tableView)
        tableView.addSubview(refreshControl)
    }
    
    func updateInsets(menuMaxY: CGFloat) {
        
        tableView.contentInset = UIEdgeInsets(top: menuMaxY, left: 0, bottom: view.frame.height, right: 0)
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
    
    override func initColors() {
        super .initColors()
        
        
    }
    
    
}

extension CryptoOrdersViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return orders.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? CryptoOrderCell  else {
            fatalError("The dequeued cell is not an instance of HomeTableViewCell.")
        }
        
        if indexPath.row < orders.count {
            cell.order = orders[indexPath.row]
        }
        
        cell.selectionStyle = .none
        
        return cell
    }
    
}

// DELEGATES

extension CryptoOrdersViewController {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
                
        guard let delegate = scrollViewDelegate else { return }
        delegate.scrollViewDidScrollVertically(scrollView: scrollView)
    }
    
}


// COLORS

//extension CryptoOrdersViewController {
//
//    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
//
//        initColors(theme: traitCollection.userInterfaceStyle)
//    }
//}
