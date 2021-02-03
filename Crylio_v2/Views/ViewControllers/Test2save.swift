//
//  Test2ViewController.swift
//  Crylio_v2
//
//  Created by Paul Bénéteau on 30/01/2021.
//

import UIKit
import SnapKit

/**

class Test2ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var navigationTopBar = NavigationTopBarView()
    var header = CryptoDetailHeaderView(name: "Bitcoin", symbol: "BTC", type: "Coin")
    var menu = HorizontalMenu(items: ["Details", "Holding", "History"])
    
    lazy var tableView: UITableView = {
        let view = UITableView()
        view.bounces = true
        return view
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController!.navigationBar.isHidden = true
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.reloadData()
        
        
        navigationTopBar.title.text = "Bitcoin"
        
        menu.delegate = self
        
        
        view.addSubview(tableView)
        view.addSubview(header)
        view.addSubview(navigationTopBar)
        view.addSubview(menu)
        
        tableView.register(CryptoDetailsTableViewCell.self, forCellReuseIdentifier: "CryptoDetailsTableViewCell")
        
        
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        navigationTopBar.snp.makeConstraints { make in
            make.left.width.top.equalToSuperview()
            make.height.equalTo(145)
        }
        
        header.snp.makeConstraints { make in
            make.left.width.top.equalToSuperview()
            make.height.equalTo(155)
        }
        
        menu.snp.makeConstraints { make in
            make.left.width.equalToSuperview()
            make.height.equalTo(35)
            make.top.equalTo(header.snp.bottom).offset(15)
        }
        
    }
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let y = scrollView.contentOffset.y
        
        if y >= 0.0 {
            
            header.snp.updateConstraints { make in
                make.top.equalToSuperview().offset(-y)
            }
            
            if header.frame.maxY <= navigationTopBar.topBar.frame.maxY {
                
                let alphaOffset = abs(header.frame.maxY - navigationTopBar.topBar.frame.maxY)/100
                
                navigationTopBar.blurredView.alpha = alphaOffset*2
                navigationTopBar.topBar.alpha = 0
                
                menu.snp.remakeConstraints { make in
                    make.left.width.equalToSuperview()
                    make.height.equalTo(35)
                    make.top.equalTo(navigationTopBar.topBar.snp.bottom).offset(8)
                    
                }
            } else {
                menu.snp.remakeConstraints { make in
                    make.left.width.equalToSuperview()
                    make.height.equalTo(35)
                    make.top.equalTo(header.snp.bottom).offset(8)
                }
                navigationTopBar.topBar.alpha = 1
            }
        } else {
            header.snp.updateConstraints { make in
                make.top.equalToSuperview()
            }
            
            menu.snp.remakeConstraints { make in
                make.left.width.equalToSuperview()
                make.height.equalTo(35)
                make.top.equalTo(header.snp.bottom).offset(8)
            }
        }
        
        if header.frame.minY <= navigationTopBar.title.frame.maxY - header.nameLabel.frame.minY - header.nameLabel.frame.height/2 {
            navigationTopBar.showTitle()
        } else {
            navigationTopBar.hideTitle()
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CryptoDetailsTableViewCell", for: indexPath) as! CryptoDetailsTableViewCell
        
        switch indexPath.row {
        case 0:
            break
        case 1:
            cell.content = ChartView(price: 13813, changePercent: 4.43, changeDollar: 451)
            break
        default:
            cell.textLabel?.text = "item \(indexPath.row)"
            break
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        switch indexPath.row {
        case 0:
            return 155 + 15 + 35
        case 1:
            return 200
        default:
            return 50
        }
    }
    
    
}


extension Test2ViewController: HorizontalMenuProtocol {
    func menuButtonTapped(sender: UIButton!) {
        print("button \(sender.tag) tapped")
    }
    
    
    
    
    
}

 */
