//
//  TestTableViewController.swift
//  Crylio_v2
//
//  Created by Paul Bénéteau on 30/01/2021.
//

import UIKit


fileprivate let cellId = "cell"

class TestTableViewController: UITableViewController {
    
    var headerView = UIView()
    var subMenuView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        navigationController!.navigationBar.prefersLargeTitles = true
        
        self.title = "Bitcoin"
        
        tableView = UITableView(frame: CGRect.zero, style: .plain)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
        
        //        let headerView: UIView = UIView.init(frame: CGRect(x: 1, y: 50, width: view.frame.width, height: 50))
        //        headerView.backgroundColor = .red
        //
        //        let labelView: UILabel = UILabel.init(frame: CGRect(x: 4, y: 5, width: 276, height: 24))
        //        labelView.text = "My header view"
        //
        //        headerView.addSubview(labelView)
        //        self.tableView.tableHeaderView = headerView
        
        headerView = HorizontalMenu(items: ["Details"], scrollable: true)
        headerView.backgroundColor = .red
        
        view.backgroundColor = .blue
        view.addSubview(headerView)
        
        headerView.addSubview(subMenuView)
        
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        if scrollView.contentOffset.y > 0 {
          if self.navigationController!.navigationBar.frame.size.height > 44.0 {
            scrollView.contentOffset.y = scrollView.contentOffset.y * 0.5
          }
        }
        
        headerView.snp.remakeConstraints { make in
            make.top.equalTo(navigationController!.navigationBar.snp.bottom).offset(headerView.frame.height)
            make.left.width.equalToSuperview()
            make.height.equalTo(300)
        }
        
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 50
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        cell.textLabel?.text = "Item \(indexPath.row)"
        return cell
    }
    
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
    override func updateViewConstraints() {
        guard let y = navigationController?.navigationBar.frame.maxY else { return }
        print(y, tableView.frame.minY)
        
        headerView.snp.makeConstraints { make in
            make.top.equalTo(navigationController!.navigationBar.snp.bottom).offset(-navigationController!.navigationBar.frame.maxY)
            make.left.width.equalToSuperview()
            make.height.equalTo(300)
        }
        
        subMenuView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.bottom.equalToSuperview().offset(-15)
            make.height.equalTo(64)
            make.width.equalTo(315)
        }
        super.updateViewConstraints()
    }
    
}
