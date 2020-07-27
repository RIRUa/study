//
//  NewObject.swift
//  study
//
//  Created by 渡辺奈央騎 on 2020/07/20.
//  Copyright © 2020 渡辺奈央騎. All rights reserved.
//

import UIKit
import CoreData

struct Vec2 {
    
    var x:CGFloat
    var y:CGFloat
    
    init(x:CGFloat,y:CGFloat) {
        self.x = x
        self.y = y
    }
    
}

enum cell_check {
    case None       //未選択
    case Fail       //非クリア
    case Clear      //クリア
}

protocol send_any_data {
    func send_bool(data:cell_check)
}
