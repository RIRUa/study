//
//  inquiryViewController.swift
//  study
//
//  Created by 渡辺奈央騎 on 2020/11/25.
//  Copyright © 2020 渡辺奈央騎. All rights reserved.
//

import UIKit
import WebKit

class inquiryViewController: UIViewController {
    
    @IBOutlet weak var webview: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let backbutton = UIBarButtonItem(barButtonSystemItem: .reply, target: self, action: #selector(pushBackButton(_:)))
        
        navigationItem.leftBarButtonItem = backbutton
        
        guard let url = Bundle.main.url(forResource: "inquiry", withExtension: "html") else {
            return
        }
        
        //print(url)
        
        webview.navigationDelegate = self
        
        self.webview.loadFileURL(url, allowingReadAccessTo: url)
        //webview.load(url)
    }
    
    
    
    @objc func pushBackButton(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
}

enum URLSchemeType: String {
    case phone = "tel"
    case email = "mailto"

    init?(scheme: String?) {
        guard let value = scheme else {
                return nil
        }
        
        switch value {
        case "tel":
            self = .phone
        case "mailto":
            self = .email
        default:
            return nil
        }
    }
}


extension inquiryViewController:WKNavigationDelegate{
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        guard let url = navigationAction.request.url,
        let scheme = url.scheme else {
            decisionHandler(.cancel)
            return
        }

        if (scheme.lowercased() == "mailto") {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
            // here I decide to .cancel, do as you wish
            decisionHandler(.cancel)
            return
        }
        decisionHandler(.allow)
    }
}

