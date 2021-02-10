//
//  ViewController.swift
//  Crylio_v2
//
//  Created by Paul Bénéteau on 27/01/2021.
//

import UIKit
import SnapKit


class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let cellId = "CryptoTableViewCell"
    
    lazy var header = HomeHeaderPortfolioView()
    lazy var homeTableView = HomeTableView()
    
    lazy var portfolio = UILabel()
    lazy var walletBalance = UILabel()
    lazy var balanceChange = UILabel()
    lazy var balanceChangeFiat = UILabel()
    
    
    var cryptos = [Cryptocurrency]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        homeTableView.delegate = self
        homeTableView.dataSource = self
        
        homeTableView.register(HomeTableViewCell.self, forCellReuseIdentifier: cellId)
        homeTableView.separatorStyle = .none
        
        view.addSubview(header)
        view.addSubview(homeTableView)
        
        loadCryptos()
        
        updateConstraints()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        //header.animate(duration: 0.5, newTopColor: .systemBackground, newBottomColor: .systemRed)
        
        header.startLoadingAnimation()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cryptos.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 79
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = self.homeTableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? HomeTableViewCell  else {
            fatalError("The dequeued cell is not an instance of HomeTableViewCell.")
        }
        
        cell.crypto = cryptos[indexPath.row]
        cell.selectionStyle = .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        performSegue(withIdentifier: "presentCryptocurrency", sender: indexPath.row)
        let controller = CryptocurrencyViewController()

        navigationController?.pushViewController(controller, animated: true)
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if let selectedRow = sender as? Int {
//            guard let destinationVC = segue.destination as? CryptocurrencyDetailViewController else {return}
//            destinationVC.crypto = cryptos[selectedRow]
//        }
//    }
    
    func loadCryptos() {
        
        guard let crypto1 = Cryptocurrency(id: 0,
                                           name: "Bitcoin",
                                           slug: "bitcoin",
                                           symbol: "BTC",
                                           description: "Bitcoin is first.",
                                           balance: 343492.98,
                                           amount: 11.2,
                                           price: 34467.15,
                                           change: 4.56,
                                           iconName: "btc")
        else {
            fatalError("Unable to instantiate crypto1")
        }
        
        cryptos += [crypto1, crypto1, crypto1, crypto1, crypto1]
        
        homeTableView.reloadData()
    }
    
    
}

extension HomeViewController {
    
    func updateConstraints() {
        
        header.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.top.equalToSuperview().offset(60)
            make.width.equalToSuperview().offset(-32)
            make.height.equalTo(180)
        }
        
        homeTableView.snp.makeConstraints { make in
            make.top.equalTo(header.snp.bottom).offset(55)
            make.left.equalTo(header)
            make.width.equalTo(header)
            make.bottom.equalToSuperview()
        }
        
    }
}
