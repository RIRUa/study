//
//  WNPasswordTextfield.swift
//  WN_UserInterfaces
//
//  Created by RIRUa on 2021/02/20.
//

import UIKit

open class WNPasswordTextfield: UITextField {
    
    public var viewEnable:Bool
    private var calledTime: Int = 0
    
    private let button = UIButton()
    
    
    public init() {
        
        // 変数に設定
        viewEnable = false
        super.init(frame: .zero)
        self.keyboardType = .asciiCapable
        
        let image = UIImage(named: "closeEye.png")
        self.button.setImage(image, for: .normal)
        //self.button.backgroundColor = .black
        
        let size = CGSize(
            width: 150,
            height: 20
        )
        
        self.frame.size = CGSize(width: size.width, height: size.height)
        
        self.rightView = button
        rightViewMode = .always
        self.button.addTarget(self, action: #selector(pushed_Eye(_:)), for: .touchUpInside)
        
        self.isSecureTextEntry = true
        self.borderStyle = .roundedRect
        self.layer.cornerRadius = 10
    }
    
    
    public init(TextfieldSize size: CGSize) throws {
        
        
        if size.height < 20 || size.width < 50 {
            throw WNError.sizeSmaller
        } else if size.width > 400 {
            throw WNError.sizeOver
        }
        
        // 変数に設定
        viewEnable = false
        super.init(frame: .zero)
        self.keyboardType = .asciiCapable
        
        let image = UIImage(named: "closeEye.png")
        self.button.setImage(image, for: .normal)
        //self.button.backgroundColor = .black
        
        self.frame.size = CGSize(width: size.width, height: size.height)
        
        self.rightView = button
        rightViewMode = .always
        self.button.addTarget(self, action: #selector(pushed_Eye(_:)), for: .touchUpInside)
        
        self.isSecureTextEntry = true
        self.borderStyle = .roundedRect
        self.layer.cornerRadius = 10
    }
    
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    @objc func pushed_Eye (_ sender: UIButton) {
        
        var pictName:String = ""
        
        
        if self.viewEnable == false {
            
            pictName = "openEye.png"
            self.viewEnable = true
            self.isSecureTextEntry = false
            
        }else{
            
            pictName = "closeEye.png"
            self.viewEnable = false
            self.isSecureTextEntry = true
        }
        
        let image = UIImage(named: pictName)
        self.button.setImage(image, for: .normal)
        
    }
    
}

