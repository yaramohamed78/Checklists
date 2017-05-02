//
//  IconCell.swift
//  CheckLists
//
//  Created by yara mohamed on 4/29/17.
//  Copyright © 2017 yara mohamediCode. All rights reserved.
//

import Foundation
import UIKit
class IconCell : UITableViewCell
{

    @IBOutlet weak var iconImage: UIImageView!
    
    @IBOutlet weak var iconDescription: UILabel!
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    override func prepareForReuse()
    {
        iconImage.image = nil
        iconDescription.text = ""
    }


}
