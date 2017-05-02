//
//  CheckList.swift
//  CheckLists
//
//  Created by yara mohamed on 4/28/17.
//  Copyright © 2017 yara mohamediCode. All rights reserved.
//

import Foundation
import UIKit
class CheckList : NSObject
{

    var title : String = ""
    var icon : UIImage? =  #imageLiteral(resourceName: "No Icon")
    var items : [CheckListItem] = []
    
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(title, forKey: "Title")
        aCoder.encode(items, forKey: "Items")
    }
    
    required init?(coder aDecoder: NSCoder) {
        title = aDecoder.decodeObject(forKey: "Title") as! String
        items = aDecoder.decodeObject(forKey: "Items") as! [CheckListItem]
        super.init()
    }
    override init() {
        super.init()
    }

}
