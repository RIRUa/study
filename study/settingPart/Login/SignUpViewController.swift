//
//  SignUpViewController.swift
//  study
//
//  Created by 渡辺奈央騎 on 2020/11/26.
//  Copyright © 2020 渡辺奈央騎. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {
    
    @IBOutlet weak var scrollview: UIScrollView!
    
    //名前
    let nameLabel = UILabel()
    let nameTextfield = UITextField()
    
    //パスワード
    let passwordLabel = UILabel()
    let passwordTextfield = UITextField()
    
    //パスワード確認
    let passwordCheckLabel = UILabel()
    let passwordCheckTextfield = UITextField()
    
    //メールアドレス
    let mailaddressLabel = UILabel()
    let mailaddressTextfield = UITextField()
    
    //性別
    let sexLabel = UILabel()
    let sexTextfield = UITextField()
    
    //電話番号
    let tellNoLabel = UILabel()
    let tellNoTextfield = UITextField()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let backbutton = UIBarButtonItem(barButtonSystemItem: .reply, target: self, action: #selector(pushBackButton(_:)))
        
        navigationItem.leftBarButtonItem = backbutton
    }
    
    @objc func pushBackButton(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    private func configureCV(){
        
        let contentView = UIView();
        contentView.frame = CGRect(
            x: 0,
            y: 0,
            width: self.view.frame.width,
            height: 2*self.view.frame.height
        )
        
        self.scrollview.addSubview(contentView)
    }
    
}
