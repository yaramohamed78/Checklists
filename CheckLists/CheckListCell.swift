//
//  CheckListCell.swift
//  CheckLists
//
//  Created by yara mohamed on 4/28/17.
//  Copyright © 2017 yara mohamediCode. All rights reserved.
//

import Foundation

import UIKit

class CheckListCell : UITableViewCell
{
    
    
    
    @IBOutlet weak var listIcon: UIImageView!
    
    
    
    @IBOutlet weak var checkListTitle: UILabel!
    
    
    @IBOutlet weak var itemsCount: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    override func prepareForReuse()
    {
        checkListTitle.text = ""
        listIcon.image = #imageLiteral(resourceName: "No Icon")
        itemsCount.text = ""
    }
}
