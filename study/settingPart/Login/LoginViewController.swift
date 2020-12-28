//
//  LoginViewController.swift
//  study
//
//  Created by 渡辺奈央騎 on 2020/11/21.
//  Copyright © 2020 渡辺奈央騎. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    
    @IBOutlet weak var userNameTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let backbutton = UIBarButtonItem(barButtonSystemItem: .reply, target: self, action: #selector(pushBackButton(_:)))
        
        navigationItem.leftBarButtonItem = backbutton
        
        userNameTextfield.placeholder = "アカウント名"
        passwordTextfield.placeholder = "パスワード"
        loginButton.layer.cornerRadius = 5
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
}
