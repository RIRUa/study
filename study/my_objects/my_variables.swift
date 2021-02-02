//
//  my_variables.swift
//  study
//
//  Created by 渡辺奈央騎 on 2020/07/20.
//  Copyright © 2020 渡辺奈央騎. All rights reserved.
//

import UIKit
import CoreData
import Firebase

struct user {
    let userName:String
    let mailAddress:String
    let age:Int
    let sex:Bool/**True:男, False:女**/
    let tellNo:String
    let userId:String
    let lastLogin_time:Date     //最終ログイン日時
    let SleepingTime_hour:Int   //就寝時間(時)
    let SleepingTime_minute:Int //就寝時間(分)
    
    init(mailaddress:String, userid uid:String) {
        self.userName = ""
        self.mailAddress = mailaddress
        self.age = 10
        self.sex = true
        self.tellNo = ""
        self.userId = uid
        self.lastLogin_time = Date()
        self.SleepingTime_hour = 0
        self.SleepingTime_minute = 0
    }
    
    init(data:[String:Any]) {
        self.userName = data["userName"] as! String
        self.mailAddress = data["mailAddress"] as! String
        self.age = data["age"] as! Int
        self.sex = data["sex"] as! Bool
        self.tellNo = data["tellNo"] as! String
        self.userId = data["uid"] as! String
        self.lastLogin_time = (data["lastLoginTime"] as! Timestamp).dateValue()
        self.SleepingTime_hour = data["Sleep_hour"] as! Int
        self.SleepingTime_minute = data["Sleep_munite"] as! Int
    }
    
    func getUserData() -> [String:Any] {
        let datas: [String:Any] = [
            "userName":self.userName,
            "mailAddress":self.mailAddress,
            "age":self.age,
            "sex":self.sex,
            "tellNo":self.tellNo,
            "uid":self.userId,
            "lastLoginTime":Timestamp(date: self.lastLogin_time),
            "Sleep_hour":self.SleepingTime_hour,
            "Sleep_munite":self.SleepingTime_minute
        ]
        
        return datas
    }
    
}

struct Vec2 {
    
    var x:CGFloat
    var y:CGFloat
    
    init(x:CGFloat,y:CGFloat) {
        self.x = x
        self.y = y
    }
    
}

enum cell_check: Int {
    case None   = 0       //未選択
    case Fail   = 1       //非クリア
    case Clear  = 2      //クリア
}
