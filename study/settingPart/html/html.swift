//
//  terms_of_service_ViewController.swift
//  study
//
//  Created by 渡辺奈央騎 on 2020/11/24.
//  Copyright © 2020 渡辺奈央騎. All rights reserved.
//

import UIKit
import WebKit

class htmlViewController: UIViewController, WKNavigationDelegate {
    
    @IBOutlet weak var webview: WKWebView!
    
    var htmlFile: String!
    
    /**　webviewを一つ前に戻す　**/
    @IBOutlet weak var back_webview: UIBarButtonItem!
    /**　webviewを一つ後に戻す　**/
    @IBOutlet weak var forword_webview: UIBarButtonItem!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let backbutton = UIBarButtonItem(barButtonSystemItem: .reply, target: self, action: #selector(pushBackButton(_:)))
        
        navigationItem.leftBarButtonItem = backbutton
        
        guard let url = Bundle.main.url(forResource: htmlFile, withExtension: "html") else {
            return
        }
        
        //print(url)
        
        self.webview.loadFileURL(url, allowingReadAccessTo: url)
        //webview.load(url)
        
        /**　スワイプ操作の許可　**/
        self.webview.allowsBackForwardNavigationGestures = true
        
        /**　拡大の不許可　**/
        self.webview.translatesAutoresizingMaskIntoConstraints = false
        self.webview.navigationDelegate = self
        
        /**　ボタンの不活性化　**/
        self.back_webview.isEnabled = false
        self.forword_webview.isEnabled = false
    }
    
    /**　webviewを一つ前に戻す関数　**/
    @IBAction func back_the_webview(_ sender: Any) {
        
        if self.webview.canGoBack == true {
            self.webview.goBack()
        }
        
    }
    
    @IBAction func forword_the_webview(_ sender: Any) {
        self.webview.goForward()
    }
    
    
    
    @objc func pushBackButton(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
}

extension htmlViewController{
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        
        /**　ブラウザを一つ前に戻せるかできるか　**/
        if webview.canGoBack == true {
            back_webview.tintColor = nil
            back_webview.isEnabled = true
        } else {
            back_webview.tintColor = .gray
            back_webview.isEnabled = false
        }
        
        /**　ブラウザを一つ後にできるか　**/
        if webview.canGoForward == true {
            forword_webview.tintColor = nil
            forword_webview.isEnabled = true
        } else {
            forword_webview.tintColor = .gray
            forword_webview.isEnabled = false
        }
    }
    
    /**　webview.goback()でのブラウザの移動時のUIの動きを改善する　**/
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        webview.reload()
    }
    
    
}
