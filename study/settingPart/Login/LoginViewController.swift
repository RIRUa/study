//
//  LoginViewController.swift
//  study
//
//  Created by 渡辺奈央騎 on 2020/11/21.
//  Copyright © 2020 渡辺奈央騎. All rights reserved.
//

import UIKit
import Firebase
import PKHUD

class LoginViewController: UIViewController {
    
    var selectedTextfield: UITextField?
    
    @IBOutlet weak var mailAddressTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let backbutton = UIBarButtonItem(barButtonSystemItem: .reply, target: self, action: #selector(pushBackButton(_:)))
        
        navigationItem.leftBarButtonItem = backbutton
        
        mailAddressTextfield.placeholder = "メールアドレス"
        passwordTextfield.placeholder = "パスワード"
        loginButton.layer.cornerRadius = 5
        
        mailAddressTextfield.delegate = self
        passwordTextfield.delegate = self
        
        mailAddressTextfield.textContentType = .emailAddress
        passwordTextfield.textContentType = .password
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        /*************************************　アプリ起動時の画面遷移の書き込み　***************************/
        
        if Auth.auth().currentUser != nil {
            GoToMasterVC()
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        /**ログアウトから戻ってきたときにテキストをからにする用**/
        mailAddressTextfield.text = ""
        passwordTextfield.text = ""
        /**パスワードを見られないようにする用**/
        passwordTextfield.isSecureTextEntry = true
        
//        /**パスワードの自動入力に対応**/
//        mailAddressTextfield.textContentType = .emailAddress
//        passwordTextfield.textContentType = .password
        
    }
    
    @objc func pushBackButton(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func signUpButton(_ sender: Any) {
        
        let storyBoard = UIStoryboard(name: "LogIO", bundle: nil)
        let SignUpVC = storyBoard.instantiateViewController(identifier: "SignUpViewController") as! SignUpViewController
        let navVC = UINavigationController(rootViewController: SignUpVC)
        navVC.modalPresentationStyle = .fullScreen
        
        present(navVC, animated: true, completion: nil)
    }
    
    @IBAction func pushLoginButton(_ sender: Any) {
        
        guard let mailAddress = mailAddressTextfield.text else {
            return
        }
        
        guard let password = passwordTextfield.text else {
            return
        }
        
        if ( mailAddress == "" || password == "" ) {
            alertBy_Mail_and_Pass(mailaddress: mailAddress, password: password)
            return
        }else{
            
            /**　グルグルを開始　**/
            HUD.show(.progress, onView: self.view)
            
            /**　ログイン処理開始　**/
            Auth.auth().signIn(withEmail: mailAddress, password: password) { [self] (result, error) in
                
                /**　ログインに失敗　**/
                if let error = error {
                    HUD.hide { (_) in
                        alertBy_Error_From_Firebase(error: error)
                    }
                    return
                }
                
                /**　ログインに成功　**/
                HUD.hide { (_) in
                    HUD.flash(.labeledSuccess(title: "ログインに成功しました", subtitle: nil),
                              onView: self.view,
                              delay: 1.0
                    ) { (_) in
                        GoToMasterVC()
                    }
                }
                
            }
            
            
        }
        
    }
    
    private func GoToMasterVC() {
        let StoryBoard = UIStoryboard(name: "Main", bundle: nil)
        let MasterVC = StoryBoard.instantiateViewController(withIdentifier: "MasterViewController") as! MasterViewController
        
        MasterVC.managedObjectContext = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
        
        let navVC = UINavigationController(rootViewController: MasterVC)
        navVC.modalPresentationStyle = .fullScreen
        
        present(navVC, animated: true, completion: nil)
    }
    
}

// MARK:- テキストフィールド関連
extension LoginViewController: UITextFieldDelegate{
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    /**選択されたテキストフィールドを保存**/
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.selectedTextfield = textField
    }
    
    // キーボードの表示
    @objc func showKeyBoard(notification: Notification){
        let keyboardFrame = (notification.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as AnyObject).cgRectValue
        
        guard let keyboardMinY = keyboardFrame?.minY else{return}
        
        var minY_Button_s_MaxY:CGFloat = 0.00
        
        if self.selectedTextfield == passwordTextfield{
            minY_Button_s_MaxY = self.passwordTextfield.frame.minY
        } else {
            return
        }
        
        let distance = minY_Button_s_MaxY - keyboardMinY + 20
        let tranceform = CGAffineTransform(translationX: 0, y: -distance)
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: [], animations: {
            self.view.transform = tranceform
        })
    }
    
    // キーボードを隠す
    @objc func hideKeyBoard(notification: Notification){
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: [], animations: {
            self.view.transform = .identity
        })
    }
    
    // onTouchBeganと同じ
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if (self.mailAddressTextfield.isFirstResponder) {
            self.mailAddressTextfield.resignFirstResponder()
        }
        
        if (self.passwordTextfield.isFirstResponder) {
            self.passwordTextfield.resignFirstResponder()
        }
        
        
        
    }
    
}

// MARK:- アラートの処理
extension LoginViewController {
    
    private func alertBy_Mail_and_Pass(mailaddress:String?,password:String? ) {
        
        var alertText:String = ""
        var called:Bool = false
        
        if mailaddress == "" {
            alertText += "メールアドレスを入力してください"
            called = true
        }
        
        if password == "" {
            if called == true {
                alertText += "\n"
            }
            alertText += "パスワードを入力してください"
        }
        
        
        let aleartController = UIAlertController(
            title: "",
            message: alertText,
            preferredStyle: .alert
        )
        
        let alertAction = UIAlertAction(
            title: "OK",
            style: .default,
            handler: nil
        )
        
        aleartController.addAction(alertAction)
        present(aleartController, animated: true, completion: nil)
    }
    
    private func alertBy_Error_From_Firebase(error: Error) {
        
        var alertText:String = ""
        
        if let errorCode = AuthErrorCode(rawValue: error._code) {
            switch errorCode {
            case .invalidEmail:
                alertText += "メールアドレスの形式が正しくありません"
                break
                
            case .emailAlreadyInUse:
                alertText += "このメールアドレスは既に使用されています"
                break
                
            case .weakPassword:
                alertText += "パスワードが脆弱なので変更してください"
                break
                
            case .operationNotAllowed:
                alertText += "メールアドレスとパスワードを使用するアカウントが有効になっていないため，お問い合わせください"
                break
                
            case .unauthorizedDomain:
                alertText += "このユーザーアカウントは存在しません."
                break
                
            case .networkError:
                alertText += "ネットワークエラーが発生しました"
                break
                
            case .wrongPassword:
                alertText += "パスワードが間違っています"
                break
                
            case .userDisabled:
                alertText += "アカウントが無効になっています．お問い合わせください"
                break
                
            case .userNotFound:
                alertText += "アカウントが存在しません"
                break
                
            default:
                alertText += "予測不可能なエラーなので状況を含めてお問い合わせで教えてください"
            }
        }
        
        let aleartController = UIAlertController(
            title: "",
            message: alertText,
            preferredStyle: .alert
        )

        let alertAction = UIAlertAction(
            title: "OK",
            style: .default,
            handler: nil
        )

        aleartController.addAction(alertAction)
        present(aleartController, animated: true, completion: nil)
    }
    
}
