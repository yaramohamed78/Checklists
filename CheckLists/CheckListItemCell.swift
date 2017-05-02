//
//  CheckListItemCell.swift
//  CheckLists
//
//  Created by yara mohamed on 4/28/17.
//  Copyright © 2017 yara mohamediCode. All rights reserved.
//

import Foundation

import UIKit

class CheckListItemCell: UITableViewCell
{
    
    
    @IBOutlet weak var itemTitleLabel: UILabel!
    
    
    
    @IBOutlet weak var checkMarkLabel: UILabel!

    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    override func prepareForReuse() {
        itemTitleLabel.text = ""
        checkMarkLabel.text = ""
    }
    
}
