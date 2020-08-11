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
    
    @IBOutlet weak var otherSettingButton: UIButton!
    
    var masterViewController:MasterViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let editButton = UIBarButtonItem(title: "Done", style: .done, target: masterViewController, action: #selector(masterViewController.tuppedEdit_In_MasterVC))
        masterViewController.navigationItem.leftBarButtonItem = editButton
        
        masterViewController.isEditing = true
        
        /**テキストフィールドの文字数制限用設定**/
        settingNotificate()
    }
    
    
    // MARK: -テキストフィールドの文字数制限用プロパティの定義
    
    /**テキストフィールドの文字数制限用設定プロパティ**/
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
    
}

