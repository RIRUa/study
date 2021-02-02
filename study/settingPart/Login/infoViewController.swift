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
    
    //メールアドレス
    let mailaddressLabel = UILabel()
    let mailaddressTextfield = UITextField()
    
    //パスワード
    let passwordLabel = UILabel()
    let passwordTextfield = UITextField()
    
    //年齢
    let ageLabel = UILabel()
    let ageTextField = UITextField()
    
    //性別
    let sexLabel = UILabel()
    let sexTextfield = UITextField()
    
    //電話番号
    let tellNoLabel = UILabel()
    let tellNoTextfield = UITextField()
    
    //ユーザーID
    let userIdLabel = UILabel()
    
    //最終ログイン日
    let Last_Login_DateLabel = UILabel()
    
    //就寝時間(通知しない時間)
    let SleepingTime_hourLabel = UILabel()
    let SleepingTime_minuteLabel = UILabel()
    let SleepingTime_hourTextfield = UITextField()
    let SleepingTime_minuteTextfield = UITextField()
    
    
    
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
        
        let space_4_textfield:UIView = UIView(
            frame:
                                                CGRect(
                                                    x: 0,
                                                    y: 0,
                                                    width: 13*self.contentView.frame.height/screenSlasher.y,
                                                    height: 8*self.contentView.frame.height/screenSlasher.y
                                                )
        )
        
        nameLabel.text = "名前"
        nameLabel.font = nameLabel.font.withSize(self.view.frame.height/screenSlasher.y*20)
        nameLabel.sizeToFit()
        nameLabel.center = CGPoint(
            x: 20*self.contentView.frame.width/screenSlasher.x,
            y: 10*self.contentView.frame.height/screenSlasher.y
        )
        self.contentView.addSubview(nameLabel)
        
        nameTextfield.frame.size = CGSize(
            width: 200*self.contentView.frame.width/screenSlasher.x,
            height: 10*self.contentView.frame.height/screenSlasher.y
        )
        nameTextfield.frame = CGRect(
            x: (self.contentView.frame.width - nameTextfield.frame.size.width)/2 ,
            y: nameLabel.frame.maxY + 30,
            width: 200*self.contentView.frame.width/screenSlasher.x,
            height: 10*self.contentView.frame.height/screenSlasher.y
        )
        nameTextfield.placeholder = "変更後の名前"
        nameTextfield.layer.cornerRadius = 5.0
        nameTextfield.layer.borderWidth = 0.5*self.contentView.frame.height/screenSlasher.y
        nameTextfield.layer.borderColor = UIColor.lightGray.cgColor
        nameTextfield.borderStyle = .none
        nameTextfield.keyboardType = .default
        nameTextfield.clearButtonMode = .always
        nameTextfield.leftView = space_4_textfield
        nameTextfield.leftViewMode = .always
        self.contentView.addSubview(nameTextfield)
        
    }
    
}
