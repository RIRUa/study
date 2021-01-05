//
//  LogoutViewController.swift
//  study
//
//  Created by 渡辺奈央騎 on 2020/11/21.
//  Copyright © 2020 渡辺奈央騎. All rights reserved.
//

import UIKit
import Firebase
import PKHUD

class LogoutViewController: UIViewController {
    
    @IBOutlet weak var LogOUT_Button: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let backbutton = UIBarButtonItem(barButtonSystemItem: .reply, target: self, action: #selector(pushBackButton(_:)))
        
        LogOUT_Button.addTarget(self, action: #selector(Logout(_:)), for: .touchUpInside)
        
        navigationItem.leftBarButtonItem = backbutton
    }
    
    @objc func Logout(_ sender:UIButton) {
        
        HUD.show(.progress, onView: self.view)
        
        do {
            try Auth.auth().signOut()
        } catch {
            
            HUD.hide { (_) in
                
                HUD.flash(.error,
                          onView: self.view,
                          delay: 1.0,
                          completion: nil
                )
            }
            
            return
        }
        
        HUD.hide { (_) in
            HUD.flash(.success,
                      onView: self.view,
                      delay: 1.0
            )
        }
        
        /**戻る時の処理  (要変更)**/
        UserDefaults.standard.setValue(false, forKey: "Login")
        self.navigationController?.presentingViewController?.presentingViewController?.presentingViewController?.dismiss(animated: true,completion: nil)
        
    }
    
    @objc func pushBackButton(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
}
