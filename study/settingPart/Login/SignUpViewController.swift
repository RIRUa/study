//
//  SignUpViewController.swift
//  study
//
//  Created by 渡辺奈央騎 on 2020/12/01.
//  Copyright © 2020 渡辺奈央騎. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let backbutton = UIBarButtonItem(barButtonSystemItem: .reply, target: self, action: #selector(pushBackButton(_:)))
        navigationItem.leftBarButtonItem = backbutton
    }
    
    
    @objc func pushBackButton(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
}
