//
//  privacy_policyViewController.swift
//  study
//
//  Created by 渡辺奈央騎 on 2020/11/20.
//  Copyright © 2020 渡辺奈央騎. All rights reserved.
//

import UIKit
import WebKit

class privacy_policyViewController: UIViewController {
    
    @IBOutlet weak var webview: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let backbutton = UIBarButtonItem(barButtonSystemItem: .reply, target: self, action: #selector(pushBackButton(_:)))
        
        navigationItem.leftBarButtonItem = backbutton
        
        guard let url = Bundle.main.url(forResource: "privacy_policy", withExtension: "html") else {
            return
        }
        
        //print(url)
        
        self.webview.loadFileURL(url, allowingReadAccessTo: url)
        
    }
    
    @objc func pushBackButton(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
}
