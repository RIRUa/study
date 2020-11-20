//
//  DetailViewController.swift
//  study
//
//  Created by 渡辺奈央騎 on 2020/07/20.
//  Copyright © 2020 渡辺奈央騎. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, UITextFieldDelegate {
    
    var cell_check_sender : send_any_data?
    
    var selectedTextField : UITextField?
    
    /**計算問題用変数**/
    var a1 = Int.random(in: 1 ... 100)
    var b1 = Int.random(in: 1 ... 100)
    var a2 = Int.random(in: 1 ... 100)
    var b2 = Int.random(in: 1 ... 100)
    var a3 = Int.random(in: 1 ... 10)
    var b3 = Int.random(in: 1 ... 10)
    var a4 = Int.random(in: 10 ... 100)
    var b4 = Int.random(in: 1 ... 10)
    
    var check1:Bool = false
    var check2:Bool = false
    var check3:Bool = false
    var check4:Bool = false
    
    
    let screen:CGSize = UIScreen.main.bounds.size//画面のサイズ
    let screen_slasher = Vec2(x: 200,y: 500)//オブジェクトの座標管理用
    let label_space:CGFloat = 100//ラベル等の管理用
    var textfield_size = Vec2(x: (UIScreen.main.bounds.size.width * 100)/200, y: (UIScreen.main.bounds.size.height * 15)/500)
    
    let label1 = UILabel()//タイトル「もんだい１」
    let label2 = UILabel()//タイトル「もんだい２」
    let label3 = UILabel()//タイトル「もんだい３」
    let label4 = UILabel()//タイトル「もんだい４」
    
    let question1 = UILabel()//足算用
    let question2 = UILabel()//引き算用
    let question3 = UILabel()//掛け算用
    let question4 = UILabel()//割り算用
    
    
    let button1 = UIButton();
    let button2 = UIButton();
    let button3 = UIButton();
    let button4 = UIButton();
    
    var textfield1 = UITextField()
    var textfield2 = UITextField()
    var textfield3 = UITextField()
    var textfield4_sho = UITextField()
    var textfield4_amari = UITextField()
    
    var time:Date!
    var timecount = Int()
    var timeLabel = UILabel()
    
    
    func configureView() {
        // Update the user interface for the detail item.
        
        /********************もんだいタイトルで表示する文字の決定********************/
        label1.text = "もんだい1"
        label1.sizeToFit()//ラベルを文字のサイズにする（ピチピチにつめる）
        label2.text = "もんだい2"
        label2.sizeToFit()//ラベルを文字のサイズにする（ピチピチにつめる）
        label3.text = "もんだい3"
        label3.sizeToFit()//ラベルを文字のサイズにする（ピチピチにつめる）
        label4.text = "もんだい4"
        label4.sizeToFit()//ラベルを文字のサイズにする（ピチピチにつめる）
        
        /********************問題内容で表示する文字の決定********************/
        
        question1.text = "\(a1)+\(b1)"
        question1.sizeToFit()
        if b2 > a2 {
            let box = b2
            b2 = a2
            a2 = box
        }
        
        question2.text = "\(a2)-\(b2)"
        question2.sizeToFit()
        
        question3.text = "\(a3)×\(b3)"
        question3.sizeToFit()
        
        question4.text = "\(a4)÷\(b4)"
        question4.sizeToFit()
        
        /********************ボタンに表示する文字の決定********************/
        
        button1.setTitle("CHECK", for: .normal)
        button2.setTitle("CHECK", for: .normal)
        button3.setTitle("CHECK", for: .normal)
        button4.setTitle("CHECK", for: .normal)
        
        /********************timeLabelに表示する文字の決定********************/
        timeLabel.text = "残り時間" + String(timecount) + "秒"
        timeLabel.sizeToFit()
        
        
    }
    
    @objc func check_ans1(sender:UIButton){
        if Int(textfield1.text!) == a1+b1 {
            button1.setTitle("cleared", for: .normal)
            button1.backgroundColor = UIColor.blue
            check1 = true
            textfield1.isUserInteractionEnabled = false
            textfield1.textColor = UIColor.blue
        }else{
            textfield1.textColor = UIColor.red
        }
        
        data_send_func()
    }
    
    @objc func check_ans2(sender:UIButton){
        if Int(textfield2.text!) == a2-b2 {
            button2.setTitle("cleared", for: .normal)
            button2.backgroundColor = UIColor.blue
            check2 = true
            textfield2.isUserInteractionEnabled = false
            textfield2.textColor = UIColor.blue
        }else{
            textfield2.textColor = UIColor.red
        }
        
        data_send_func()
    }

    @objc func check_ans3(sender:UIButton){
        if Int(textfield3.text!) == a3*b3 {
            button3.setTitle("cleared", for: .normal)
            button3.backgroundColor = UIColor.blue
            check3 = true
            textfield3.isUserInteractionEnabled = false
            textfield3.textColor = UIColor.blue
        }else{
            textfield3.textColor = UIColor.red
        }
        
        data_send_func()
    }
    
    @objc func check_ans4(sender:UIButton){
        if ((Int(textfield4_sho.text!) == a4/b4 && Int(textfield4_amari.text!) == a4%b4) || (Int(textfield4_sho.text!) == a4/b4 && a4%b4 == 0)) {
            button4.setTitle("cleared", for: .normal)
            button4.backgroundColor = UIColor.blue
            check4 = true
            textfield4_sho.isUserInteractionEnabled = false
            textfield4_sho.textColor = UIColor.blue
            textfield4_amari.isUserInteractionEnabled = false
            textfield4_amari.textColor = UIColor.blue
        }else{
            
            if Int(textfield4_sho.text!) == a4/b4 {
                textfield4_sho.isUserInteractionEnabled = false
                textfield4_sho.textColor = UIColor.blue
                
                textfield4_amari.textColor = UIColor.red
            }
            
            if Int(textfield4_amari.text!) == a4%b4 {
                textfield4_amari.isUserInteractionEnabled = false
                textfield4_amari.textColor = UIColor.blue
                
                textfield4_sho.textColor = UIColor.red
            }
        }
        
        data_send_func()
    }

    
    private func data_send_func() {
        
        if (check1 == true && check2 == true && check3 == true && check4 == true) {
            
            if time.distance(to: Date()) <= TimeInterval(timecount) {
                cell_check_sender?.send_data(data: .Clear)
            }else{
                cell_check_sender?.send_data(data: .Fail)
            }
            
        }
        
    }
    
    private func labelSetting(){
        label1.textAlignment = NSTextAlignment.center;//ラベルを中央揃えにする
        label1.font = label1.font.withSize(screen.height/screen_slasher.y*10)
        label1.center = CGPoint(x: screen.width/2, y: screen.height*0.7*label_space/screen_slasher.y)//位置の設定
        self.view.addSubview(label1)
        
        label2.textAlignment = NSTextAlignment.center;//ラベルを中央揃えにする
        label2.font = label2.font.withSize(screen.height/screen_slasher.y*10)
        label2.center = CGPoint(x: screen.width/2, y: screen.height*1.7*label_space/screen_slasher.y)//位置の設定
        self.view.addSubview(label2)
        
        label3.textAlignment = NSTextAlignment.center;//ラベルを中央揃えにする
        label3.font = label3.font.withSize(screen.height/screen_slasher.y*10)
        label3.center = CGPoint(x: screen.width/2, y: screen.height*2.7*label_space/screen_slasher.y)//位置の設定
        self.view.addSubview(label3)
        
        label4.textAlignment = NSTextAlignment.center;//ラベルを中央揃えにする
        label4.font = label4.font.withSize(screen.height/screen_slasher.y*10)
        label4.center = CGPoint(x: screen.width/2, y: screen.height*3.7*label_space/screen_slasher.y)//位置の設定
        self.view.addSubview(label4)
        
    }
    
    private func QuestionCreater(){
        question1.textAlignment = NSTextAlignment.center
        question1.font = question1.font.withSize(screen.height/screen_slasher.y*10)
        question1.center = CGPoint(x: screen.width/2, y: screen.height*0.85*label_space/screen_slasher.y)//位置の設定
        self.view.addSubview(question1)
        
        question2.textAlignment = NSTextAlignment.center
        question2.font = question2.font.withSize(screen.height/screen_slasher.y*10)
        question2.center = CGPoint(x: screen.width/2, y: screen.height*1.85*label_space/screen_slasher.y)//位置の設定
        self.view.addSubview(question2)
        
        question3.textAlignment = NSTextAlignment.center
        question3.font = question3.font.withSize(screen.height/screen_slasher.y*10)
        question3.center = CGPoint(x: screen.width/2, y: screen.height*2.85*label_space/screen_slasher.y)//位置の設定
        self.view.addSubview(question3)
        
        question4.textAlignment = NSTextAlignment.center
        question4.font = question4.font.withSize(screen.height/screen_slasher.y*10)
        question4.center = CGPoint(x: screen.width/2, y: screen.height*3.85*label_space/screen_slasher.y)//位置の設定
        self.view.addSubview(question4)
        
    }
    
    private func buttonSetting(){
        
        button1.titleLabel?.textAlignment = NSTextAlignment.center
        button1.sizeToFit()
        button1.layer.cornerRadius = 5
        button1.center = CGPoint(x: screen.width/2, y: screen.height * 1.3 * label_space/screen_slasher.y)//ボタンを中央揃え
        button1.titleLabel?.font = button1.titleLabel?.font.withSize(screen.height/screen_slasher.y*10)//フォントサイズ
        button1.backgroundColor = UIColor.red//ボタンの色
        button1.titleLabel?.textColor = UIColor.white//ボタンの文字の色
        button1.addTarget(self, action: #selector(check_ans1), for: .touchUpInside)
        self.view.addSubview(button1)
        
        button2.titleLabel?.textAlignment = NSTextAlignment.center
        button2.sizeToFit()
        button2.layer.cornerRadius = 5
        button2.center = CGPoint(x: screen.width/2, y: screen.height * 2.3 * label_space/screen_slasher.y)//ボタンを中央揃え
        button2.titleLabel?.font = button2.titleLabel?.font.withSize(screen.height/screen_slasher.y*10)//フォントサイズ
        button2.backgroundColor = UIColor.red//ボタンの色
        button2.titleLabel?.textColor = UIColor.white//ボタンの文字の色
        button2.addTarget(self, action: #selector(check_ans2), for: .touchUpInside)
        self.view.addSubview(button2)
        
        button3.titleLabel?.textAlignment = NSTextAlignment.center
        button3.sizeToFit()
        button3.layer.cornerRadius = 5
        button3.center = CGPoint(x: screen.width/2, y: screen.height * 3.3 * label_space/screen_slasher.y)//ボタンを中央揃え
        button3.titleLabel?.font = button3.titleLabel?.font.withSize(screen.height/screen_slasher.y*10)//フォントサイズ
        button3.backgroundColor = UIColor.red//ボタンの色
        button3.titleLabel?.textColor = UIColor.white//ボタンの文字の色
        button3.addTarget(self, action: #selector(check_ans3), for: .touchUpInside)
        self.view.addSubview(button3)
        
        button4.titleLabel?.textAlignment = NSTextAlignment.center
        button4.sizeToFit()
        button4.layer.cornerRadius = 5
        button4.center = CGPoint(x: screen.width/2, y: screen.height * 4.3 * label_space/screen_slasher.y)//ボタンを中央揃え
        button4.titleLabel?.font = button4.titleLabel?.font.withSize(screen.height/screen_slasher.y*10)//フォントサイズ
        button4.backgroundColor = UIColor.red//ボタンの色
        button4.titleLabel?.textColor = UIColor.white//ボタンの文字の色
        button4.addTarget(self, action: #selector(check_ans4), for: .touchUpInside)
        self.view.addSubview(button4)
        
    }
    
    private func textfieldSetting(){
        
        NotificationCenter.default.addObserver(self, selector: #selector(showKeyBoard(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(hideKeyBoard(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        
        textfield1.frame = CGRect(x: (screen.width - textfield_size.x)/2 , y: (screen.height * 1.0 * label_space)/screen_slasher.y, width: textfield_size.x, height: textfield_size.y)
        textfield1.placeholder = "和（たし算の答え）"
        textfield1.keyboardType = .numberPad
        textfield1.borderStyle = .roundedRect
        textfield1.clearButtonMode = .always
        self.view.addSubview(textfield1)
        textfield1.delegate = self
        
        textfield2.frame = CGRect(x: (screen.width - textfield_size.x)/2 , y: (screen.height * 2.0 * label_space)/screen_slasher.y, width: textfield_size.x, height: textfield_size.y)
        textfield2.placeholder = "差（ひき算の答え）"
        textfield2.keyboardType = .numberPad
        textfield2.borderStyle = .roundedRect
        textfield2.clearButtonMode = .always
        self.view.addSubview(textfield2)
        textfield2.delegate = self
        
        textfield3.frame = CGRect(x: (screen.width - textfield_size.x)/2 , y: (screen.height * 3.0 * label_space)/screen_slasher.y, width: textfield_size.x, height: textfield_size.y)
        textfield3.placeholder = "積（かけ算の答え）"
        textfield3.keyboardType = .numberPad
        textfield3.borderStyle = .roundedRect
        textfield3.clearButtonMode = .always
        self.view.addSubview(textfield3)
        textfield3.delegate = self
        
        textfield4_sho.frame = CGRect(x: (screen.width - textfield_size.x)/2 , y: (screen.height * 4.0 * label_space)/screen_slasher.y, width: textfield_size.x/2-5, height: textfield_size.y)
        textfield4_sho.placeholder = "商"
        textfield4_sho.keyboardType = .numberPad
        textfield4_sho.borderStyle = .roundedRect
        textfield4_sho.clearButtonMode = .always
        self.view.addSubview(textfield4_sho)
        textfield4_sho.delegate = self
        
        textfield4_amari.frame = CGRect(x: (screen.width)/2+5 , y: (screen.height * 4.0 * label_space)/screen_slasher.y, width: textfield_size.x/2, height: textfield_size.y)
        textfield4_amari.placeholder = "余"
        textfield4_amari.keyboardType = .numberPad
        textfield4_amari.borderStyle = .roundedRect
        textfield4_amari.clearButtonMode = .always
        self.view.addSubview(textfield4_amari)
        textfield4_amari.delegate = self
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.selectedTextField = textfield1
        
        time = Date()
        timecount = UserDefaults.standard.integer(forKey: "TIME")
        
        Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.change_timeLabel), userInfo: nil, repeats: true)
        
        labelSetting()
        /********************問題の設定********************/
        QuestionCreater()
        
        /********************ボタンの設定********************/
        buttonSetting()
        
        /********************テキストフィールドの設定********************/
        textfieldSetting()
        
        timeLabel.textAlignment = NSTextAlignment.center;//ラベルを中央揃えにする
        timeLabel.font = timeLabel.font.withSize(screen.height/screen_slasher.y*7.5)
        self.view.addSubview(timeLabel)
        
        configureView()
    }
    
    
    @objc func showKeyBoard(notification: Notification){
        let keyboardFrame = (notification.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as AnyObject).cgRectValue
        
        guard let keyboardMinY = keyboardFrame?.minY else{return}
        
        var minY_Button_s_MaxY:CGFloat = 0.00
        
        if self.selectedTextField == textfield3 {
            minY_Button_s_MaxY = self.button3.frame.maxY
        }else if (self.selectedTextField == textfield4_sho || self.selectedTextField == textfield4_amari) {
            minY_Button_s_MaxY = self.button4.frame.maxY
        }else{
            return
        }
        
        let distance = minY_Button_s_MaxY - keyboardMinY + 20
        let tranceform = CGAffineTransform(translationX: 0, y: -distance)
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: [], animations: {
            self.view.transform = tranceform
        })
    }
    
    @objc func hideKeyBoard(notification: Notification){
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: [], animations: {
            self.view.transform = .identity
        })
    }
    
    /**選択されたテキストフィールドを保存**/
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.selectedTextField = textField
    }
    
    var detailItem: Past_Data? {
        didSet {
            // Update the view.
            configureView()
            
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if (self.textfield1.isFirstResponder) {
            self.textfield1.resignFirstResponder()
        }
        
        if (self.textfield2.isFirstResponder) {
            self.textfield2.resignFirstResponder()
        }
        
        if (self.textfield3.isFirstResponder) {
            self.textfield3.resignFirstResponder()
        }
        
        if (self.textfield4_sho.isFirstResponder) {
            self.textfield4_sho.resignFirstResponder()
        }
        
        if (self.textfield4_amari.isFirstResponder) {
            self.textfield4_amari.resignFirstResponder()
        }
        
    }
    
    //カウントダウン関数
    
    @objc func change_timeLabel(){
        
        timeLabel.text = "残り時間 " + String(timecount) + "秒"
        timeLabel.center = CGPoint(x: screen.width - timeLabel.frame.width/2 - 10, y: screen.height - timeLabel.frame.height/2 - 75)//位置の設定
        timeLabel.sizeToFit()
        timecount -= 1
    }

}
