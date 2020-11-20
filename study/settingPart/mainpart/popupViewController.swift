//
//  popupViewController.swift
//  study
//
//  Created by 渡辺奈央騎 on 2020/08/10.
//  Copyright © 2020 渡辺奈央騎. All rights reserved.
//

import UIKit

class popupViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var passwordKeyword: UILabel!
    @IBOutlet weak var passwordText1: UITextField!
    @IBOutlet weak var passwordText2: UITextField!
    @IBOutlet weak var passwordText3: UITextField!
    @IBOutlet weak var passwordText4: UITextField!
    @IBOutlet weak var passwordText5: UITextField!
    @IBOutlet weak var passwordText6: UITextField!
    
    @IBOutlet weak var pw_CheckButton: UIButton!
    
    var masterViewController:MasterViewController!
    
    var pass1:String!
    var pass2:String!
    var pass3:String!
    var pass4:String!
    var pass5:String!
    var pass6:String!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pw_CheckButton.layer.cornerRadius = 10
        pw_CheckButton.backgroundColor = .systemOrange
        pw_CheckButton.tintColor = .white
        
        textfieldFeature(textfield: passwordText1)
        textfieldFeature(textfield: passwordText2)
        textfieldFeature(textfield: passwordText3)
        textfieldFeature(textfield: passwordText4)
        textfieldFeature(textfield: passwordText5)
        textfieldFeature(textfield: passwordText6)
        
        let pass_number = Int.random(in: 0..<1000000)
        passwordKeyword.text = "\(pass_number)"
        
        pass1 = capital1(input: pass_number)
        pass2 = capital2(input: pass_number)
        pass3 = capital3(input: pass_number)
        pass4 = capital4(input: pass_number)
        pass5 = capital5(input: pass_number)
        pass6 = capital6(input: pass_number)
        
        
        /**テキストフィールドの文字数制限用設定**/
        settingNotificate()
    }
    
    @IBAction func touchPWcheckButtton(_ sender: Any) {
        
        if ((passwordText1.text == pass1) && (passwordText2.text == pass2) && (passwordText3.text == pass3) && (passwordText4.text == pass4) && (passwordText5.text == pass5) && (passwordText6.text == pass6)){
            PW_Check_Is_Cleared()
            dismiss(animated: true, completion: nil)
        }
        
    }
    
    // MARK: -テキストフィールドの文字数制限用メソッドの定義
    
    /**テキストフィールドの文字数制限用設定メソッド**/
    private func settingNotificate(){
        NotificationCenter.default.addObserver(self, selector: #selector(textField1DidChange(notification:)), name: UITextField.textDidChangeNotification, object: passwordText1)
        NotificationCenter.default.addObserver(self, selector: #selector(textField2DidChange(notification:)), name: UITextField.textDidChangeNotification, object: passwordText2)
        NotificationCenter.default.addObserver(self, selector: #selector(textField3DidChange(notification:)), name: UITextField.textDidChangeNotification, object: passwordText3)
        NotificationCenter.default.addObserver(self, selector: #selector(textField4DidChange(notification:)), name: UITextField.textDidChangeNotification, object: passwordText4)
        NotificationCenter.default.addObserver(self, selector: #selector(textField5DidChange(notification:)), name: UITextField.textDidChangeNotification, object: passwordText5)
        NotificationCenter.default.addObserver(self, selector: #selector(textField6DidChange(notification:)), name: UITextField.textDidChangeNotification, object: passwordText6)
    }
    
    // オブザーバの破棄
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func textField1DidChange(notification: NSNotification){
        textfieldS_Word_upstair(textField: passwordText1)
    }
    
    @objc func textField2DidChange(notification: NSNotification){
        textfieldS_Word_upstair(textField: passwordText2)
    }
    
    @objc func textField3DidChange(notification: NSNotification){
        textfieldS_Word_upstair(textField: passwordText3)
    }
    
    @objc func textField4DidChange(notification: NSNotification){
        textfieldS_Word_upstair(textField: passwordText4)
    }
    
    @objc func textField5DidChange(notification: NSNotification){
        textfieldS_Word_upstair(textField: passwordText5)
    }
    
    @objc func textField6DidChange(notification: NSNotification){
        textfieldS_Word_upstair(textField: passwordText6)
    }
    
    /**テキストフィールドの文字数を制限する関数**/
    private func textfieldS_Word_upstair(textField:UITextField){
        if let text = textField.text {
            if textField.markedTextRange == nil && text.count > 1 {
                textField.text = text.prefix(1).description
            }
        }
    }
    
    private func textfieldFeature(textfield: UITextField){
        textfield.layer.borderColor = UIColor.black.cgColor
        textfield.layer.borderWidth = 1.0
        textfield.layer.cornerRadius = 10
        textfield.textColor = .black
    }
    
    private func PW_Check_Is_Cleared(){
        let editButton = UIBarButtonItem(title: "Done", style: .done, target: masterViewController, action: #selector(masterViewController.tuppedEdit_In_MasterVC))
        masterViewController.navigationItem.leftBarButtonItem = editButton
        
        masterViewController.isEditing = true
    }
    
    @IBAction func pushSettingButton(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: "SETTING", bundle: nil)
        let SettingVC = storyboard.instantiateViewController(identifier: "settingViewController") as! settingViewController
        
        SettingVC.modalPresentationStyle = .fullScreen
        
        present(SettingVC, animated: true, completion: nil)
        
    }
    
}

