//
//  infoViewController.swift
//  study
//
//  Created by 渡辺奈央騎 on 2020/11/26.
//  Copyright © 2020 渡辺奈央騎. All rights reserved.
//

import UIKit

class infoViewController: UIViewController {
    
    @IBOutlet weak var scrollview: UIScrollView!
    
    let contentView = UIView()
    
    let screenSlasher = Vec2(x: 300, y: 800)
    
    //名前
    let nameLabel = UILabel()
    let nameTextfield = UITextField()
    
    //パスワード
    let passwordLabel = UILabel()
    let passwordTextfield = UITextField()
    
    //年齢
    let ageLabel = UILabel()
    let ageTextField = UITextField()
    
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
        
        //navigationControllerのボタンの設置
        let backbutton = UIBarButtonItem(barButtonSystemItem: .reply, target: self, action: #selector(pushBackButton(_:)))
        navigationItem.leftBarButtonItem = backbutton
        
        //scrollViewのサイズを設定し、その上にcontentViewを乗せる
        makeView_and_fitScrollview()
        
        //ラベルとテキストフィールドの設定と貼り付け
        Label_and_Textfield_Setting()
    }
    
    @objc func pushBackButton(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    private func makeView_and_fitScrollview(){
        
        contentView.frame = CGRect(
            x: 0,
            y: 0,
            width: self.view.frame.width,
            height: 2*self.view.frame.height
        )
        
        self.scrollview.addSubview(contentView)
        scrollview.contentSize = contentView.frame.size
        
        
    }
    
    private func Label_and_Textfield_Setting() {
        
        nameLabel.text = "名前"
        nameLabel.font = nameLabel.font.withSize(self.view.frame.height/screenSlasher.y*20)
        nameLabel.sizeToFit()
        nameLabel.center = CGPoint(
            x: 20*self.contentView.frame.width/screenSlasher.x,
            y: 10*self.contentView.frame.height/screenSlasher.y
        )
        self.contentView.addSubview(nameLabel)
        
    }
    
}
