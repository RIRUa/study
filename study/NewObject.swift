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

/**
func enumCell_to_CoreData(cell_state: cell_check)->Past_Datas {
    
    let data : Past_Datas = Past_Datas()
    data.is_this_challenged = false
    data.is_this_cleared = false
    
    if cell_state == .Clear {
        data.is_this_challenged = true
        data.is_this_cleared = true
    }else if cell_state == .Fail{
        data.is_this_challenged = true
    }
    
    return data
}

func CoreData_to_enumCell(data:Past_Datas)->cell_check {
    
    if data.is_this_challenged == true {
        if data.is_this_cleared == true {
            return .Clear
        }
        return .Fail
    }
    
    
    return .None
}

**/

// MARK: -use COREDATA

extension NSPersistentContainer {
    
    /// viewContextで保存
    func saveContext() {
        saveContext(context: viewContext)
    }

    /// 指定したcontextで保存
    /// マルチスレッド環境でのバックグラウンドコンテキストを使う場合など
    func saveContext(context: NSManagedObjectContext) {
        
        // 変更がなければ何もしない
        guard context.hasChanges else {
            return
        }
        
        do {
            try context.save()
        }
        catch let error as NSError {
            print("Error: \(error), \(error.userInfo)")
        }
    }
}
