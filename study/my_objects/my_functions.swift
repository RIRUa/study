//
//  my_functions.swift
//  study
//
//  Created by 渡辺奈央騎 on 2021/02/02.
//  Copyright © 2021 渡辺奈央騎. All rights reserved.
//

import UIKit
import Firebase

func determine_grade(sliderValue val:Int)-> String{
    
    var chugaku:Bool = false
    var grade = val
    
    if grade >= 7 {
        grade -= 6
        chugaku = true
    }
    
    if chugaku == true {
        return "中学" + String(grade) + "年"
    }
    
    return "小学" + String(grade) + "年"
    
}

func settingNotification() {
    let trigger: UNNotificationTrigger
    
    //　時間
    var CallTime = DateComponents()
    CallTime.hour = 20
    CallTime.minute = 00
    trigger = UNCalendarNotificationTrigger(dateMatching: CallTime, repeats: true)
    
    //　内容
    let content = UNMutableNotificationContent()
    content.title = "実験用タイトル"
    content.body = "こんにちは．\nこれは実験です．\nよろしくお願いします．"
    content.sound = UNNotificationSound.default
    
    //　設定
    let request = UNNotificationRequest(
        identifier: "uuid",
        content: content,
        trigger: trigger
    )
    UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
}
