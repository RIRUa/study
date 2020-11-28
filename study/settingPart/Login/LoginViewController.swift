//
//  LoginViewController.swift
//  study
//
//  Created by 渡辺奈央騎 on 2020/11/21.
//  Copyright © 2020 渡辺奈央騎. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let backbutton = UIBarButtonItem(barButtonSystemItem: .reply, target: self, action: #selector(pushBackButton(_:)))
        
        navigationItem.leftBarButtonItem = backbutton
    }
    
    @objc func pushBackButton(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func signUpButton(_ sender: Any) {
        
        let storyBoard = UIStoryboard(name: "LogIO", bundle: nil)
        let signUpVC = storyBoard.instantiateViewController(identifier: "SignUpViewController") as! SignUpViewController
        let navVC = UINavigationController(rootViewController: signUpVC)
        navVC.modalPresentationStyle = .fullScreen
        
        present(navVC, animated: true, completion: nil)
    }
}
