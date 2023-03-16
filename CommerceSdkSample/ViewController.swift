//
//  ViewController.swift
//  CommerceSdkSample
//
//  Created by Samyeol Kim on 2023/03/14.
//

import UIKit

class ViewController: UIViewController {

    let menu = ["SignUp","GetCommerces","Scrap","GetScrapingUsers","GetOrders"]
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Sample"
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        // Do any additional setup after loading the view.
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "menuCell", for: indexPath) as! UITableViewCell
        
        cell.textLabel?.text = menu[indexPath.row]
        cell.detailTextLabel?.text = ""
        
        if indexPath.row == 0 {
            cell.detailTextLabel?.text = UserDefaults.standard.string(forKey: PREF_USER_ID)
        }

        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menu.count
    }
}


extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "signUpVC") as? SignUpViewController else { return }
            self.navigationController?.pushViewController(vc, animated: true)
        } else if indexPath.row == 1 {
            guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "commerceTVC") as? CommerceTableViewController else { return }
            self.navigationController?.pushViewController(vc, animated: true)
        } else if indexPath.row == 2 {
//            guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "scrapVC") as? ScrapViewController else { return }
//            self.navigationController?.pushViewController(vc, animated: true)
        } else if indexPath.row == 3 {
            guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "scrapingUserVC") as? ScrapingUserViewController else { return }
            self.navigationController?.pushViewController(vc, animated: true)
        } else if indexPath.row == 4 {
            guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "orderVC") as? OrderViewController else { return }
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}


