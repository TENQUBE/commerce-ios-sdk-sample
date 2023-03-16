//
//  OrderTableViewController.swift
//  CommerceSdkSample
//
//  Created by Samyeol Kim on 2023/03/16.
//

import UIKit
import Commerce

class OrderViewController: UIViewController {
    
    var orders: [OnlineOrder] = []
    var userId: String = ""
    var userPwd: String = ""
    var commerceId: String = ""
    
    var appDelegate: AppDelegate!
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Orders"
        
        appDelegate = UIApplication.shared.delegate as? AppDelegate
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
                
        getAllOrder()
        
    }
    
    func getAllOrder(){
        appDelegate.scrapService?.getCommerces(completion: { err, rst in
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
                var commerces = [String]()
                rst?.forEach({ sc in
                    commerces.append(sc.commerce.id)
                })
                
                self.appDelegate.scrapService?.getOnlineOrders(commerceIds: commerces, completion: { err, rst in
                    self.orders.removeAll()
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
                            self.orders.append(contentsOf: rst)
                            self.tableView.reloadData()
                        }
                    }
                    
                })
            }
        })
        
    }
}

extension OrderViewController: UITableViewDataSource {
    
    // MARK: - Table view data source

    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return orders.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "orderCell", for: indexPath) as! OrderTableViewCell
        
        let order = orders[indexPath.row]
        if let orderItem = order.items.first {
            cell.nameLabel.text = orderItem.product.name
            cell.priceLabel.text = orderItem.price.key()
            
            let url = URL(string: orderItem.product.image.thumbnail)
            do {
                let data = try Data(contentsOf: url!)
                cell.thumbnail.image = UIImage(data: data)
            } catch {
                
            }
        }
        
        return cell
    }
}

extension OrderViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

