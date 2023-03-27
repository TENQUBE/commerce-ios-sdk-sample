

//
//  ViewController.swift
//  CommerceSdkSample
//
//  Created by Samyeol Kim on 2023/03/14.
//

import UIKit
import Commerce

class ViewController: UIViewController {

    let menu = ["SignUp","GetCommerces","Scrap","GetScrapingUsers","GetOrders", "ScrapBackground"]
    
    var appDelegate: AppDelegate!
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Sample"
        
        appDelegate = UIApplication.shared.delegate as? AppDelegate
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        // Do any additional setup after loading the view.
        initUser()
        
        self.tableView.reloadData()
        
        appDelegate.scrapService?.setWebViewController(vc: self, frame: self.view.bounds)
    }
    
    func initUser(){
//        UserDefaults.standard.removeObject(forKey: PREF_USER_ID)
//        UserDefaults.standard.removeObject(forKey:  PREF_USER_BIRTH)
//        UserDefaults.standard.removeObject(forKey:  PREF_USER_GENDER)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.tableView.reloadData()
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
    
    func startScrapBackground() {
        appDelegate.scrapService?.startScrapingOrderAll(completion: { err, scrapingUsers in
            
            var alertTitle = ""
            
            if err != nil {
                alertTitle = "백그라운드 스크랩 실패"
                print(err?.localizedDescription)
            } else {
                alertTitle = "백그라운드 스크랩 완료"
                // 메시지창 컨트롤러 인스턴스 생성
                print("scrap success")
            }
            
            DispatchQueue.main.async {
                let alert = UIAlertController(title: "알림", message: alertTitle, preferredStyle: UIAlertController.Style.alert)
                
                // 메시지 창 컨트롤러에 들어갈 버튼 액션 객체 생성
                let defaultAction =  UIAlertAction(title: "확인", style: UIAlertAction.Style.default)
                
                //메시지 창 컨트롤러에 버튼 액션을 추가
                alert.addAction(defaultAction)
                
                //메시지 창 컨트롤러를 표시
                self.present(alert, animated: false)
            }
        })
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
            guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "scrapVC") as? ScrapViewController else { return }
            self.navigationController?.pushViewController(vc, animated: true)
        } else if indexPath.row == 3 {
            guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "scrapingUserVC") as? ScrapingUserViewController else { return }
            self.navigationController?.pushViewController(vc, animated: true)
        } else if indexPath.row == 4 {
            guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "orderVC") as? OrderViewController else { return }
            self.navigationController?.pushViewController(vc, animated: true)
        } else if indexPath.row == 5 {
            self.startScrapBackground()
        }
    }
}


