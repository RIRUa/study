//
//  SignUpViewController.swift
//  study
//
//  Created by 渡辺奈央騎 on 2020/12/01.
//  Copyright © 2020 渡辺奈央騎. All rights reserved.
//

import UIKit
import Firebase
import PKHUD
import WN_Library

class SignUpViewController: WNtouchViewController/*, UNUserNotificationCenterDelegate */{
    
    var selectedTextfield:UITextField?
    
    /**タイトル**/
    let titleLabel = UILabel()
    
    /**メールアドレス**/
    let mailaddressLabel = UILabel()
    let mailaddressTextfield = UITextField()
    
    /**パスワード**/
    let passwordLabel = UILabel()
    var passwordTextfield: WNPasswordTextfield! = nil
    
    /**認証ボタン**/
    let authorizeButton = UIButton()
    
    let screenSlasher = Vec2(x: 400, y: 800)
    
    /**利用規約への遷移**/
    let term = UIButton()
    
    /**プライバシーポリシーへの遷移**/
    let privacy = UIButton()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let backbutton = UIBarButtonItem(barButtonSystemItem: .reply, target: self, action: #selector(pushBackButton(_:)))
        navigationItem.leftBarButtonItem = backbutton
        
        makeView()
    }
    
    
    private func makeView() {
        let Screen_Size = self.view.frame.size
        let textfieldSize:CGFloat = 30.0
        
        //タイトル：”SignUp”
        titleLabel.text = "アカウント作成"
        titleLabel.font = titleLabel.font.withSize(self.view.frame.height/screenSlasher.y*50)
        titleLabel.sizeToFit()
        titleLabel.center = CGPoint(
            x: Screen_Size.width/2,
            y: Screen_Size.height/screenSlasher.y*175
        )
        self.view.addSubview(self.titleLabel)
        
        
        //メールアドレス
        mailaddressLabel.text = "メールアドレス"
        mailaddressLabel.font = mailaddressLabel.font.withSize(self.view.frame.height/screenSlasher.y*20)
        mailaddressLabel.sizeToFit()
        mailaddressLabel.center = CGPoint(
            x: Screen_Size.width/screenSlasher.x*0 + mailaddressLabel.frame.size.width/2 + 20,
            y: Screen_Size.height/screenSlasher.y*325
        )
        self.view.addSubview(mailaddressLabel)
        
        
        mailaddressTextfield.frame.size = CGSize(
            width: Screen_Size.width - Screen_Size.width/screenSlasher.x*50,
            height: Screen_Size.height/screenSlasher.y*textfieldSize
        )
        mailaddressTextfield.center = CGPoint(
            x: Screen_Size.width/2,
            y: Screen_Size.height/screenSlasher.y*360
        )
        mailaddressTextfield.placeholder = "メールアドレス"
        mailaddressTextfield.keyboardType = .emailAddress
        mailaddressTextfield.borderStyle = .roundedRect
        mailaddressTextfield.clearButtonMode = .always
        mailaddressTextfield.textContentType = .emailAddress
        self.view.addSubview(mailaddressTextfield)
        self.addTextfield(textfield: mailaddressTextfield)
        
        
        //パスワード
        passwordLabel.text = "パスワード"
        passwordLabel.font = passwordLabel.font.withSize(self.view.frame.height/screenSlasher.y*20)
        passwordLabel.sizeToFit()
        passwordLabel.center = CGPoint(
            x: Screen_Size.width/screenSlasher.x*0 + passwordLabel.frame.size.width/2 + 20,
            y: Screen_Size.height/screenSlasher.y*425
        )
        self.view.addSubview(passwordLabel)
        
        do {
            
            let Textfieldsize = CGSize(
                width: Screen_Size.width - Screen_Size.width/screenSlasher.x*50,
                height: Screen_Size.height/screenSlasher.y*textfieldSize
            )
            
            passwordTextfield = try WNPasswordTextfield(TextfieldSize: Textfieldsize)
            passwordTextfield.frame.size = CGSize(
                width: Screen_Size.width - Screen_Size.width/screenSlasher.x*50,
                height: Screen_Size.height/screenSlasher.y*textfieldSize
            )
            passwordTextfield.center = CGPoint(
                x: Screen_Size.width/2,
                y: Screen_Size.height/screenSlasher.y*460
            )
            passwordTextfield.placeholder = "パスワード"
            passwordTextfield.keyboardType = .asciiCapable
            passwordTextfield.textContentType = .newPassword
            self.view.addSubview(passwordTextfield)
            self.addTextfield(textfield: passwordTextfield)
            
        } catch {
            print(error.localizedDescription)
        }
        
        let height:CGFloat = 530.0
        
        //利用規約
        term.setTitle("利用規約", for: .normal)
        term.backgroundColor = .purple
        term.frame.size = CGSize(
            width: Screen_Size.width/screenSlasher.x*80,
            height: Screen_Size.height/screenSlasher.y*30
        )
        term.frame.origin = CGPoint(
            x: (Screen_Size.width/2 - term.frame.width)/2 - 5,
            y: Screen_Size.height/screenSlasher.y*height
        )
        term.layer.cornerRadius = 5
        term.addTarget(self, action: #selector(GotoTermOfService(sender:)), for: .touchUpInside)
        self.view.addSubview(term)
        
        //プライバシーポリシー
        privacy.setTitle("プライバシーポリシー", for: .normal)
        privacy.backgroundColor = .systemPurple
        privacy.frame.size = CGSize(
            width: Screen_Size.width/screenSlasher.x*200,
            height: Screen_Size.height/screenSlasher.y*30
        )
        privacy.frame.origin = CGPoint(
            x: term.frame.maxX + 10,
            y: Screen_Size.height/screenSlasher.y*height
        )
        privacy.layer.cornerRadius = 5
        privacy.addTarget(self, action: #selector(GotoPrivacyPolicy(sender:)), for: .touchUpInside)
        self.view.addSubview(privacy)
        
        //認証ボタン
        
        authorizeButton.setTitle("SignUp", for: .normal)
        authorizeButton.titleLabel?.textColor = .white
        authorizeButton.frame.size = CGSize(
            width: Screen_Size.width/screenSlasher.x*150,
            height: Screen_Size.height/screenSlasher.y*40
        )
        authorizeButton.center = CGPoint(
            x: (Screen_Size.width)/2,
            y: Screen_Size.height/screenSlasher.y*600
        )
        authorizeButton.backgroundColor = .orange
        authorizeButton.layer.cornerRadius = 5
        authorizeButton.titleLabel?.font = authorizeButton.titleLabel?.font.withSize(Screen_Size.height/screenSlasher.y*30)
        authorizeButton.addTarget(self, action: #selector(authorize(sender:)), for: .touchUpInside)
        self.view.addSubview(authorizeButton)
        
        self.register_textfieldDelegate()
    }
    
}

// MARK:- @objc関数
extension SignUpViewController{
    
    @objc func pushBackButton(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func authorize(sender: UIButton) {
        guard let mailAddress = mailaddressTextfield.text else{
            return
        }
        guard let password = passwordTextfield.text else{
            return
        }
        
        if ( mailAddress == "" || password == "" ) {
            /**mailAddressもpasswordもnilでなくても空である可能性があるから**/
            alertBy_Mail_and_Pass(mailaddress: mailAddress, password: password)
        }else{
            HUD.show(.progress, onView: self.view)
            Auth.auth().createUser(
                withEmail: mailAddress,
                password: password
            ) {[self] (result, error) in /**クロージャーなのでselfが必要**/
                
                if error != nil {
                    /**エラーがあったら**/
                    
                    if let error = error {
                        HUD.hide { (_) in
                            alertBy_Error_From_Firebase(error: error)
                        }
                    }
                    return
                }
                /**エラーがないので認証成功した時の処理**/
                
                guard let uid = Auth.auth().currentUser?.uid else{
                    return
                }
                
                let initialData = user(mailaddress: mailAddress, userid: uid)
                
                let datas: [String:Any] = initialData.getUserData()
                
                /**　firestoreに情報を登録　**/
                Firestore.firestore().collection("Users").document(uid).setData(datas) { (errorBy_setData) in
                    
                    /***************************　情報の保存に失敗した場合　**********************/
                    if errorBy_setData != nil{
                        HUD.hide { (_) in
                            HUD.flash(
                                .labeledError(title: "情報の保存に失敗しました", subtitle: nil),
                                delay: 1.0
                            )
                            return
                        }
                    }
                }
                
                /***************************　情報の保存に成功した場合　**********************/
                HUD.hide { (_) in
                    HUD.flash(.labeledSuccess(title: "情報の保存に成功しました", subtitle: nil),
                              onView: self.view,
                              delay: 1.0
                    ) { (_) in
                        if #available(iOS 10.0, *) {
                            
                            let center = UNUserNotificationCenter.current()
                            center.requestAuthorization(
                                options: [.badge, .sound, .alert]
                            ) { [self] (granted, error) in
                                
                                if error != nil {
                                    return
                                }
                                
                                if granted == true {
                                    let center = UNUserNotificationCenter.current()
                                    center.delegate = self
                                }
                                
                                settingNotification()
                                
                            }
                        }
                        dismiss(animated: true, completion: nil)
                        
                    }
                }
                
            }
        }
        
    }
    
    @objc func GotoTermOfService(sender: UIButton) {
        let StoryBoard = UIStoryboard(name: "html", bundle: nil)
        let htmlVC = StoryBoard.instantiateViewController(identifier: "htmlViewController") as! htmlViewController
        htmlVC.htmlFile = "terms_of_service"
        let navVC = UINavigationController(rootViewController: htmlVC)
        navVC.modalPresentationStyle = .fullScreen
        present(navVC, animated: true, completion: nil)
    }
    
    @objc func GotoPrivacyPolicy(sender:UIButton) {
        let StoryBoard = UIStoryboard(name: "html", bundle: nil)
        let htmlVC = StoryBoard.instantiateViewController(identifier: "htmlViewController") as! htmlViewController
        htmlVC.htmlFile = "privacy_policy"
        let navVC = UINavigationController(rootViewController: htmlVC)
        navVC.modalPresentationStyle = .fullScreen
        present(navVC, animated: true, completion: nil)
    }
}

// MARK:- テキストフィールド関連
extension SignUpViewController{
    
    // onTouchBeganと同じ
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        super.touchesBegan(touches, with: event)
        
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesMoved(touches, with: event)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
    }
    
}

// MARK:- アラート関連
extension SignUpViewController {
    
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
