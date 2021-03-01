//
//  my_extensions.swift
//  study
//
//  Created by 渡辺奈央騎 on 2021/02/02.
//  Copyright © 2021 渡辺奈央騎. All rights reserved.
//

import UIKit
import Firebase

extension Date{
    
    /**
     *
     *      @author : watanao
     *      @param : day
     *
     *      最近かどうか（２日前以内か）
     *
     */
    func is_RecentDay(day: Date) -> Bool {
        
        //２日前
        let twoDays_past = day.addingTimeInterval(-60*60*2)
        
        if self >= twoDays_past {
            return true
        }
        
        return false
    }
    
}

extension UITableViewCell {
    
    func setTitleText(Text: String) {
        self.textLabel?.text = Text
    }
    
}
