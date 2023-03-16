//
//  CommerceTableViewController.swift
//  CommerceSdkSample
//
//  Created by Samyeol Kim on 2023/03/16.
//

import UIKit
import Commerce

class CommerceTableViewController: UITableViewController {
    
    var commerces = [ScrapingCommerce]()
    var users = [ScrapingUser]()

    var onReload : ((Bool) -> Void)?
    
    var appDelegate: AppDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Commerce List"

        appDelegate = UIApplication.shared.delegate as? AppDelegate

        appDelegate.scrapService?.setWebViewController(vc: self, frame: self.view.bounds)
        
        appDelegate.scrapService?.getCommerces(completion: { err, items in
            print(items ?? [])
            self.commerces.removeAll()
            self.commerces.append(contentsOf: items ?? [])
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        })
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return commerces.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "commerceCell", for: indexPath) as! CommerceTableViewCell
        
        // Configure the cell...
        
        let commerce = commerces[indexPath.row]
        cell.nameLabel.text = commerce.commerce.name
        
        let url = URL(string: commerce.commerce.icon.origin)
        do {
            let data = try Data(contentsOf: url!)
            cell.logoImageView.image = UIImage(data: data)
        } catch {

        }

        return cell
    }
}
