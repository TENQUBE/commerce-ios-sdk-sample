//
//  ScrapViewController.swift
//  CommerceSdkSample
//
//  Created by Samyeol Kim on 2023/03/16.
//
import UIKit
import Commerce

class ScrapViewController: UIViewController {
    
    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var pwdTitleTextField: UILabel!
    @IBOutlet weak var pwdTextField: UITextField!
    @IBOutlet weak var commerceTextField: UITextField!
    @IBOutlet weak var scrapButton: UIButton!
    @IBOutlet weak var resultTextView: UITextView!
    
    var commerces: [ScrapingCommerce] = []
    var selectedCommerce: ScrapingCommerce?
    var users = [ScrapingUser]()
    
    var appDelegate: AppDelegate!

    
    var isLogin = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Scrap"
        
        appDelegate = UIApplication.shared.delegate as? AppDelegate
        
        appDelegate.scrapService?.setWebViewController(vc: self, frame: self.view.bounds)
        
        resultTextView.text = ""
        
        setPickerViews()
        
        getCommerces()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    func setPickerViews(){
        let commercePickerView = UIPickerView()
        commercePickerView.delegate = self
        
        commerceTextField.inputView = commercePickerView
        commerceTextField.tintColor = .clear
        
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        
        var buttons: [UIBarButtonItem] = []
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        let button = UIBarButtonItem(title: "선택", style: .plain, target: self, action: #selector(self.pickerAction))
        
        buttons.append(flexibleSpace)
        buttons.append(button)
        
        toolBar.setItems(buttons, animated: true)
        toolBar.isUserInteractionEnabled = true
        
        commerceTextField.inputAccessoryView = toolBar
    }
    
    @IBAction func pickerAction(_ sender: Any) {
        self.commerceTextField.resignFirstResponder()
    }
    
    func getCommerces(){
        appDelegate.scrapService?.getCommerces(completion: { err, commerces in
            self.commerces.removeAll()
            self.commerces.append(contentsOf: commerces ?? [])
        })
    }
    
    @IBAction func startScrapTapped(_ sender: Any) {
        startScrap()
    }
    
    func startScrap(){
        guard let _id = self.idTextField.text, let _pwd = self.pwdTextField.text else {
            showAlert("아이디와 패스워드를 입력해주세요")
            return
        }
        
        guard let _commerceId = selectedCommerce?.commerce.id else {
            showAlert("잘못된 쇼핑몰입니다.")
            return
        }
        
        resultTextView.text = "스크랩 중..."
        
        idTextField.resignFirstResponder()
        pwdTextField.resignFirstResponder()
        
        self.scrapButton.isEnabled = false
        appDelegate.scrapService?.startLogin(id:  _id, pwd: _pwd, commerceId: _commerceId, completion: { err in
            
            DispatchQueue.main.async {
                if err != nil {
                    self.printError(err: err as! CommonError)
                    
                    self.scrapButton.isEnabled = true
                } else {
                    self.appDelegate.scrapService?.startScrapingOrder(id: _id, pwd: _pwd, commerceId: _commerceId, completion: { err, scrapingResut in
                        
                        if err != nil {
                            self.printError(err: err as! CommonError)
                        } else {
                            self.resultTextView.text = "code: \(scrapingResut?.code.rawValue)\nmessage: \(scrapingResut?.msg ?? "")"
                        }
                        self.scrapButton.isEnabled = true
                    })
                }
            }
        })
    }
    
    func printError(err: CommonError){
        self.resultTextView.text = err.localizedDescription
        switch err {
        case .message(_):
            break;
        case .parameterError:
            break;
        case .authError:
            break;
        case .forbiddenError:
            break;
        case .serverError:
            break;
        case .networkError:
            break;
        case .uncaughtError:
            break;
        case .loginError(let message):
            self.resultTextView.text = message
            return
        }
    }
    
//    func goOrders(id: String, pwd: String, commerceId: String){
//        DispatchQueue.main.async {
//            guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "orderVC") as? OrderViewController else { return }
//            vc.mode = .one
//    //        vc.commerceId = commerceId
//    //                // 화면 전환 애니메이션 설정
//    //                secondViewController.modalTransitionStyle = .coverVertical
//    //                // 전환된 화면이 보여지는 방법 설정 (fullScreen)
//    //                secondViewController.modalPresentationStyle = .fullScreen
//            
//            vc.userId = id
//            vc.userPwd = pwd
//            vc.commerceId = commerceId
//            
//            self.navigationController?.pushViewController(vc, animated: true)
//        }
//    }
    
    func showAlert(_ message: String){
        // 메시지창 컨트롤러 인스턴스 생성
        let alert = UIAlertController(title: "알림", message: message, preferredStyle: UIAlertController.Style.alert)

        // 메시지 창 컨트롤러에 들어갈 버튼 액션 객체 생성
        let defaultAction =  UIAlertAction(title: "확인", style: UIAlertAction.Style.default)

        //메시지 창 컨트롤러에 버튼 액션을 추가
        alert.addAction(defaultAction)
    
        //메시지 창 컨트롤러를 표시
        self.present(alert, animated: false)
    }
}

extension ScrapViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if row == 0 {
            commerceTextField.text = "- 선택 -"
            self.selectedCommerce = nil
        } else {
            commerceTextField.text = "\(commerces[row-1].commerce.name)"
            self.selectedCommerce = commerces[row-1]
        }
    }
}


extension ScrapViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }


    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return commerces.count + 1
    }


    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if row == 0 {
            return "- 선택 -"
        } else {
            return String(self.commerces[row-1].commerce.name)
        }
        
    }
}
