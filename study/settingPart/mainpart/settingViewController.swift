//
//  settingViewController.swift
//  study
//
//  Created by 渡辺奈央騎 on 2020/09/05.
//  Copyright © 2020 渡辺奈央騎. All rights reserved.
//

import UIKit

class settingViewController:UIViewController{
    
    
    //userdefault用
    let userdefault = UserDefaults.standard
    var grade_data:Int?
    let grade_data_Name:String = "GRADE"
    var time_data:Int?
    let time_data_Name:String = "TIME"
    
    //学年設定
    @IBOutlet weak var gradeLabel: UILabel!//学年設定：X学X年
    @IBOutlet weak var gradeSlider: UISlider!
    
    //時間制限
    @IBOutlet weak var timeLabel: UILabel!//X分XX秒
    @IBOutlet weak var timeSlider: UISlider!
    
    //アカウント情報
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var age: UILabel!
    @IBOutlet weak var sex: UILabel!
    @IBOutlet weak var mailAddress: UILabel!
    @IBOutlet weak var telephoneNo: UILabel!
    
    //プライバシーポリシー
    @IBOutlet weak var privacy_policy: UIButton!
    
    //制作理念
    @IBOutlet weak var production_philosophy: UIButton!
    
    //利用規約
    @IBOutlet weak var terms_of_service: UIButton!
    
    //お問い合わせ
    @IBOutlet weak var inquiry: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        get_Userdefault()
        
        if (grade_data == nil) {
            gradeSlider.value = 5.0
            gradeLabel.text = "学年設定：" + determine_grade(sliderValue: Int(self.gradeSlider.value))
        }else{
            gradeSlider.value = Float(self.grade_data!)
            gradeLabel.text = "学年設定：" + determine_grade(sliderValue: Int(self.gradeSlider.value))
            
        }
        
        if time_data == nil {
            timeSlider.value = 75
            let min:Int = Int(self.timeSlider.value)/60
            let sec:Int = Int(self.timeSlider.value)%60
            timeLabel.text = String(min) + "分" + String(sec) + "秒"
        }else{
            timeSlider.value = Float(self.time_data!)
            let min:Int = Int(self.timeSlider.value)/60
            let sec:Int = Int(self.timeSlider.value)%60
            timeLabel.text = String(min) + "分" + String(sec) + "秒"
        }
        
    }
    
    // MARK: -USERDEFAULT
    
    func get_Userdefault() {
        self.grade_data = userdefault.integer(forKey: grade_data_Name)
        self.time_data  = userdefault.integer(forKey: time_data_Name)
    }
    
    
    // MARK: -Slider functions
    @IBAction func gradeSetting(_ sender: Any) {
        gradeLabel.text = "学年設定：" + determine_grade(sliderValue: Int(self.gradeSlider.value))
        userdefault.set(Int(self.gradeSlider.value), forKey: grade_data_Name)
    }
    
    @IBAction func timeSetting(_ sender: Any) {
        
        let min:Int = Int(self.timeSlider.value)/60
        let sec:Int = Int(self.timeSlider.value)%60
        timeLabel.text = String(min) + "分" + String(sec) + "秒"
        
        userdefault.set(Int(timeSlider.value), forKey: time_data_Name)
    }
    
    // MARK: -画面遷移
    
    //ホームへの遷移
    @IBAction func GO_Home(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    //プライバシーポリシーへの遷移
    @IBAction func privacy_policyButton(_ sender: Any) {
        let storyBoard = UIStoryboard(name: "html", bundle: nil)
        let htmlVC = storyBoard.instantiateViewController(identifier: "htmlViewController") as! htmlViewController//privacy_policyViewControllerのインスタンスの作成
        htmlVC.htmlFile = "privacy_policy"
        let navVC = UINavigationController(rootViewController: htmlVC)
        
        navVC.modalPresentationStyle = .fullScreen
        
        present(navVC, animated: true, completion: nil)
    }
    
    //制作理念への遷移
    @IBAction func product_philosophyButton(_ sender: Any) {
        
        let storyBoard = UIStoryboard(name: "html", bundle: nil)
        let htmlVC = storyBoard.instantiateViewController(identifier: "htmlViewController") as! htmlViewController//production_philosophyViewControllerのインスタンスの作成
        htmlVC.htmlFile = "production_philosophy"
        
        let navVC = UINavigationController(rootViewController: htmlVC)
        navVC.modalPresentationStyle = .fullScreen
        
        present(navVC, animated: true, completion: nil)
        
    }
    
    //利用規約への遷移
    @IBAction func terms_of_serviceButton(_ sender: Any) {
        let storyBoard = UIStoryboard(name: "html", bundle: nil)
        let htmlVC = storyBoard.instantiateViewController(identifier: "htmlViewController") as! htmlViewController
        htmlVC.htmlFile = "terms_of_service"
        
        let navVC = UINavigationController(rootViewController: htmlVC)
        navVC.modalPresentationStyle = .fullScreen
        
        present(navVC, animated: true, completion: nil)
        
    }
    
    //お問い合わせへの遷移
    @IBAction func inquiryButton(_ sender: Any) {
        let storyBoard = UIStoryboard(name: "html", bundle: nil)
        let htmlVC = storyBoard.instantiateViewController(identifier: "htmlViewController") as! htmlViewController
        htmlVC.htmlFile = "inquiry"
        
        let navVC = UINavigationController(rootViewController: htmlVC)
        navVC.modalPresentationStyle = .fullScreen
        
        present(navVC, animated: true, completion: nil)
        
    }
    
    @IBAction func LogoutButton(_ sender: Any) {
        
        let storyBoard = UIStoryboard(name: "LogIO", bundle: nil)
        let LogoutVC = storyBoard.instantiateViewController(identifier: "LogoutViewController") as LogoutViewController
        let navVC = UINavigationController(rootViewController: LogoutVC)
        
        navVC.modalPresentationStyle = .fullScreen
        
        present(navVC, animated: true, completion: nil)
    }
    
    @IBAction func infoButton(_ sender: Any) {
        let storyBoard = UIStoryboard(name: "LogIO", bundle: nil)
        let infoVC = storyBoard.instantiateViewController(identifier: "infoViewController") as! infoViewController
        let navVC = UINavigationController(rootViewController: infoVC)
        navVC.modalPresentationStyle = .fullScreen
        
        present(navVC, animated: true, completion: nil)
    }
}
