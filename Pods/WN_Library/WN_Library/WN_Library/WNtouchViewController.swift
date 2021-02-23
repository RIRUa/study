//
//  WNtouchViewController.swift
//  WN_UserInterfaces
//
//  Created by RIRUa on 2021/02/20.
//

import UIKit


open class WNtouchViewController: UIViewController {
    
    private let imageView = UIImageView()
    
    private var textfields: [UITextField] = []
    
    private var selectedTextfield:UITextField?
    
    
    open override func viewDidLoad() {
        
        super.viewDidLoad()
        
        /**　タップ時の画像の初期化　**/
        let picturesSize = CGFloat(30)
        let image = UIImage(named: "touchPoint.png")
        self.imageView.image = image
        self.imageView.frame.size = CGSize(
            width: picturesSize,
            height: picturesSize
        )
        imageView.isHidden = true
        self.view.addSubview(self.imageView)
        
    }
    
    open override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        self.imageView.center = CGPoint(
            x: touches.first!.location(in: self.view).x,
            y: touches.first!.location(in: self.view).y
        )
        
        imageView.isHidden = false
        
        for ATextField in textfields {
            if ATextField.isFirstResponder == true {
                ATextField.resignFirstResponder()
            }
        }
        
    }
    
    open override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        guard let touch = touches.first else {return}
        
        let pastPosition = touch.previousLocation(in: self.view)
        let nowPosition = touch.location(in: self.view)
        
        self.imageView.center.x += (nowPosition.x - pastPosition.x)
        self.imageView.center.y += (nowPosition.y - pastPosition.y)
        
    }
    
    open override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        imageView.isHidden = true
        
    }
    
    /**
     *
     *@param   textfield　登録するテキストフィールド（型は拡張後の型もOK）
     *  テキストフィールドをViewControllerに登録する関数
     *
     ***/
    public func addTextfield(textfield:UITextField) {
        
        self.textfields.append(textfield)
        
    }
    
    /**
     *
     *　テキストフィールドdelegateを登録し，テキストフィールド以外の場所をタップした時のテキストフィールド選択を解除
     *
     ***/
    public func register_textfieldDelegate() {
        for Atextfield in textfields {
            Atextfield.delegate = self
        }
        
        /**　キーボードの表示　**/
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(showKeyBoard(notification:)),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        
        /**　キーボードの非表示　**/
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(hideKeyBoard(notification:)),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }
    
    
}

extension WNtouchViewController: UITextFieldDelegate, UNUserNotificationCenterDelegate{
    
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    /**選択されたテキストフィールドを保存**/
    public func textFieldDidBeginEditing(_ textField: UITextField) {
        self.selectedTextfield = textField
    }
    
    // キーボードの表示
    @objc func showKeyBoard(notification: Notification){
        let keyboardFrame = (notification.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as AnyObject).cgRectValue
        
        /**　キーボードの大きさ　**/
        guard let keyboardMinY = keyboardFrame?.minY else{return}
        
        /**　textfieldの最下部のY座標　**/
        var minY_textfield_MaxY:CGFloat = 0.00
        
        /**　エラー処理用　**/
        var checker: Bool = false
        
        for ATextField in textfields {
            
            if self.selectedTextfield == ATextField {
                minY_textfield_MaxY = self.selectedTextfield!.frame.maxY
                checker = true
            }
            
        }
        
        if checker == false {
            return
        }
        
        let distance = minY_textfield_MaxY - keyboardMinY + 20
        
        if distance < 0 {
            return
        }
        
        let tranceform = CGAffineTransform(translationX: 0, y: -distance)
        
        UIView.animate(
            withDuration: 0.5,
            delay: 0,
            usingSpringWithDamping: 1,
            initialSpringVelocity: 1,
            options: [],
            animations: {
                self.view.transform = tranceform
            }
        )
    }
    
    // キーボードを隠す
    @objc func hideKeyBoard(notification: Notification){
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: [], animations: {
            self.view.transform = .identity
        })
    }
    
}

