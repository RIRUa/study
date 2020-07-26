//
//  Past_Datas+CoreDataProperties.swift
//  study
//
//  Created by 渡辺奈央騎 on 2020/07/24.
//  Copyright © 2020 渡辺奈央騎. All rights reserved.
//
//

import Foundation
import CoreData


extension Past_Datas {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Past_Datas> {
        return NSFetchRequest<Past_Datas>(entityName: "Past_Datas")
    }

    @NSManaged public var is_this_challenged: Bool
    @NSManaged public var is_this_cleared: Bool

}
