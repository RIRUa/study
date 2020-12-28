//
//  SignUpViewController.swift
//  study
//
//  Created by 渡辺奈央騎 on 2020/12/01.
//  Copyright © 2020 渡辺奈央騎. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {
    
    let titleLabel = UILabel()
    
    let mailaddressLabel = UILabel()
    let mailaddressTextfield = UITextField()
    
    let passwordLabel = UILabel()
    let passwordTextfield = UITextField()
    
    let authorizeButton = UIButton()
    
    let screenSlasher = Vec2(x: 400, y: 800)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let backbutton = UIBarButtonItem(barButtonSystemItem: .reply, target: self, action: #selector(pushBackButton(_:)))
        navigationItem.leftBarButtonItem = backbutton
        
        makeView()
    }
    
    
    @objc func pushBackButton(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    private func makeView() {
        let size = self.view.frame.size
        let textfieldSize:CGFloat = 25.0
        
        //タイトル：”SignUp”
        titleLabel.text = "SignUp"
        titleLabel.font = titleLabel.font.withSize(self.view.frame.height/screenSlasher.y*65)
        titleLabel.sizeToFit()
        titleLabel.center = CGPoint(
            x: size.width/2,
            y: size.height/screenSlasher.y*175
        )
        self.view.addSubview(self.titleLabel)
        
        
        //メールアドレス
        mailaddressLabel.text = "メールアドレス"
        mailaddressLabel.font = mailaddressLabel.font.withSize(self.view.frame.height/screenSlasher.y*20)
        mailaddressLabel.sizeToFit()
        mailaddressLabel.center = CGPoint(
            x: size.width/screenSlasher.x*0 + mailaddressLabel.frame.size.width/2 + 20,
            y: size.height/screenSlasher.y*325
        )
        self.view.addSubview(mailaddressLabel)
        
        
        mailaddressTextfield.frame.size = CGSize(
            width: size.width - size.width/screenSlasher.x*50,
            height: size.height/screenSlasher.y*textfieldSize
        )
        mailaddressTextfield.frame = CGRect(
            x: (size.width - mailaddressTextfield.frame.size.width)/2,
            y: size.height/screenSlasher.y*360,
            width: size.width - size.width/screenSlasher.x*50,
            height: size.height/screenSlasher.y*textfieldSize
        )
        mailaddressTextfield.placeholder = "メールアドレス"
        mailaddressTextfield.keyboardType = .default
        mailaddressTextfield.borderStyle = .roundedRect
        mailaddressTextfield.clearButtonMode = .always
        self.view.addSubview(mailaddressTextfield)
        
        
        //パスワード
        passwordLabel.text = "パスワード"
        passwordLabel.font = passwordLabel.font.withSize(self.view.frame.height/screenSlasher.y*20)
        passwordLabel.sizeToFit()
        passwordLabel.center = CGPoint(
            x: size.width/screenSlasher.x*0 + passwordLabel.frame.size.width/2 + 20,
            y: size.height/screenSlasher.y*425
        )
        self.view.addSubview(passwordLabel)
        
        passwordTextfield.frame.size = CGSize(
            width: size.width - size.width/screenSlasher.x*50,
            height: size.height/screenSlasher.y*textfieldSize
            )
        passwordTextfield.frame = CGRect(
            x: (size.width - mailaddressTextfield.frame.size.width)/2,
            y: size.height/screenSlasher.y*460,
            width: size.width - size.width/screenSlasher.x*50,
            height: size.height/screenSlasher.y*textfieldSize
        )
        passwordTextfield.placeholder = "パスワード"
        passwordTextfield.keyboardType = .default
        passwordTextfield.borderStyle = .roundedRect
        passwordTextfield.clearButtonMode = .always
        self.view.addSubview(passwordTextfield)
        
        //認証ボタン
        
        authorizeButton.setTitle("SignUp", for: .normal)
        authorizeButton.titleLabel?.textColor = .white
        authorizeButton.frame.size = CGSize(
            width: size.width/screenSlasher.x*150,
            height: size.height/screenSlasher.y*40
        )
        authorizeButton.frame = CGRect(
            x: (size.width - authorizeButton.frame.width)/2,
            y: size.height/screenSlasher.y*550,
            width: size.width/screenSlasher.x*150,
            height: size.height/screenSlasher.y*40
        )
        authorizeButton.backgroundColor = .orange
        authorizeButton.layer.cornerRadius = 5
        authorizeButton.titleLabel?.font = authorizeButton.titleLabel?.font.withSize(size.height/screenSlasher.y*30)
        authorizeButton.addTarget(self, action: #selector(authorize(sender:)), for: .touchUpInside)
        self.view.addSubview(authorizeButton)
        
    }
    
    @objc func authorize(sender: UIButton) {
        
    }
    
}
