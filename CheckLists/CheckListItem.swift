//
//  CheckListItem.swift
//  CheckLists
//
//  Created by yara mohamed on 4/25/17.
//  Copyright © 2017 yara mohamediCode. All rights reserved.
//

import Foundation


class CheckListItem : NSObject, NSCoding
{
    var text = ""
    var checked = false

    func toggleChecked()
    {
        checked = !checked
    
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(text, forKey: "Text")
        aCoder.encode(checked, forKey: "Checked")
    }
    
    required init?(coder aDecoder: NSCoder) {
        text = aDecoder.decodeObject(forKey: "Text") as! String
        checked = aDecoder.decodeBool(forKey: "Checked")
        super.init()
    }
    override init() {
        super.init()
    }
}
