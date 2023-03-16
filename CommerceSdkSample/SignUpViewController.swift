//
//  SignUpViewController.swift
//  CommerceSdkSample
//
//  Created by Samyeol Kim on 2023/03/15.
//

import Foundation
import UIKit

import Commerce

class SignUpViewController: UIViewController {

    var genders = [String]()
    var births = [String]()
    
    var appDelegate: AppDelegate!

    
    // pickerView.tag 1: 생년, 2:성별
    
    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var birthTextField: UITextField!
    @IBOutlet weak var genderTextField: UITextField!
    @IBOutlet weak var startButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Sign Up"
        
        appDelegate = UIApplication.shared.delegate as? AppDelegate
        
        genders.append("- 선택 -")
        genders.append(contentsOf: ["여성", "남성"])

        births.append("- 선택 -")
        births.append(contentsOf: (1900..<2022).map { num -> String in
            return String(num)
        })
        // Do any additional setup after loading the view.
        
        setViews()
        
        self.idTextField.text = UserDefaults.standard.string(forKey: PREF_USER_ID)
        
        self.birthTextField.text = UserDefaults.standard.string(forKey: PREF_USER_BIRTH)
        
        self.genderTextField.text = UserDefaults.standard.string(forKey: PREF_USER_GENDER)
        
        if let id = self.idTextField.text {
            if id.count > 0 {
                startButton.sendActions(for: .touchUpInside)
            }
        }
    }
    
    func setViews(){
        let birthPickerView = UIPickerView()
        let genderPickerView = UIPickerView()
        birthPickerView.delegate = self
        genderPickerView.delegate = self
        
        birthPickerView.tag = 1
        genderPickerView.tag = 2
        
        birthTextField.inputView = birthPickerView
        genderTextField.inputView = genderPickerView
        
        birthTextField.tintColor = .clear
        genderTextField.tintColor = .clear
        
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        
        var buttons: [UIBarButtonItem] = []
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        let button = UIBarButtonItem(title: "선택", style: .plain, target: self, action: #selector(self.pickerAction))
        
        buttons.append(flexibleSpace)
        buttons.append(button)
        
        toolBar.setItems(buttons, animated: true)
        toolBar.isUserInteractionEnabled = true
        
        birthTextField.inputAccessoryView = toolBar
        genderTextField.inputAccessoryView = toolBar
    }
    
    @IBAction func pickerAction(_ sender: Any) {
        self.birthTextField.resignFirstResponder()
        self.genderTextField.resignFirstResponder()
    }
    
    @IBAction func signUpTapped(_ sender: Any) {
        signUp()
    }
    
    func signUp(){
        guard let _id = idTextField.text,
              let _birth = birthTextField.text,
              let _gender = genderTextField.text
        else {
            showAlert()
            return
        }
        
        if _birth == "" || _gender == "" {
            showAlert()
            return
        }
        
        var genderValue: Gender?
        
        if _gender == "여성" {
            genderValue = .Female
        } else if _gender == "남성" {
            genderValue = .Male
        }
        
        guard let birthValue = Int(_birth) else {
            showAlert()
            return
        }
        
        appDelegate.scrapService?.signUp(clientId: _id, birth: birthValue, gender: genderValue!, completion: { err in
            print("signUp done")
            UserDefaults.standard.set(_id, forKey: PREF_USER_ID)
            UserDefaults.standard.set(_birth, forKey: PREF_USER_BIRTH)
            UserDefaults.standard.set(_gender, forKey: PREF_USER_GENDER)
            DispatchQueue.main.async {
                self.dismiss(animated: true)
            }
        })
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    func showAlert(){
        // 메시지창 컨트롤러 인스턴스 생성
        let alert = UIAlertController(title: "알림", message: "입력한 내용을 확인해주세요.", preferredStyle: UIAlertController.Style.alert)

        // 메시지 창 컨트롤러에 들어갈 버튼 액션 객체 생성
        let defaultAction =  UIAlertAction(title: "확인", style: UIAlertAction.Style.default)

        //메시지 창 컨트롤러에 버튼 액션을 추가
        alert.addAction(defaultAction)
    
        //메시지 창 컨트롤러를 표시
        self.present(alert, animated: false)
    }
}

extension SignUpViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView.tag == 1 {
            if row == 0 {
                birthTextField.text = ""
            } else {
                birthTextField.text = "\(births[row])"
            }
        } else {
            if row == 0 {
                birthTextField.text = ""
            } else {
                genderTextField.text = "\(genders[row])"
            }
        }
    }
}


extension SignUpViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }


    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView.tag == 1 {
            return births.count
        } else {
            return genders.count
        }
    }


    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView.tag == 1 {
            return String(self.births[row])
        } else {
            return self.genders[row]
        }
    }
}
