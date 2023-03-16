//
//  OrderTableViewController.swift
//  CommerceSdkSample
//
//  Created by Samyeol Kim on 2023/03/16.
//

import UIKit
import Commerce

class ScrapingUserViewController: UIViewController {
    
    var scrapingUsers: [ScrapingUser] = []
    
    var appDelegate: AppDelegate!
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "GetScrapingUsers"
        
        appDelegate = UIApplication.shared.delegate as? AppDelegate
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
                
        getScrapingUser()
        
    }
    
    func getScrapingUser(){
        appDelegate.scrapService?.getScrapingUsers(completion: { err, rst in
            if err != nil {
                print(err)
                DispatchQueue.main.async {
                    let alert = UIAlertController(title: "목록 가져오기 실패", message: err?.localizedDescription ?? "",
                                                  preferredStyle: .alert)

                    alert.addAction(UIAlertAction(title: "확인", style: .default, handler: { _ in
                        //Cancel Action
                    }))
                    self.present(alert, animated: true, completion: nil)
                }
            } else {
                print(rst)
                DispatchQueue.main.async {
                    self.scrapingUsers.append(contentsOf: rst ?? [])
                    self.tableView.reloadData()
                }
            }
        })
        
    }
}

extension ScrapingUserViewController: UITableViewDataSource {
    
    // MARK: - Table view data source

    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return scrapingUsers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "scrapingUserCell", for: indexPath) as! ScrapingUserTableViewCell
        
        let user = scrapingUsers[indexPath.row]
        cell.commerceLabel.text =  user.commerce.name
        cell.nameLabel.text = user.id
        
            
        if let url = URL(string: user.commerce.icon.origin) {
            do {
                let data = try Data(contentsOf: url)
                cell.thumbnail.image = UIImage(data: data)
            } catch {
                
            }
        } else {
            cell.thumbnail.image = nil
        }
        
        return cell
    }
}

extension ScrapingUserViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

