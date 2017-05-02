//
//  AddItemViewController.swift
//  CheckLists
//
//  Created by yara mohamed on 4/26/17.
//  Copyright © 2017 yara mohamediCode. All rights reserved.
//

import Foundation
import UIKit

class AddItemViewController : UITableViewController
{
    var delegate: AddItemViewControllerDelegate!
    var itemToEdit : CheckListItem?
    

    
    @IBOutlet weak var textField: UITextField!
  
    
    
    @IBAction func cancel()
    {
        delegate?.addItemViewControllerDidCancel(self)
    }
    
    @IBAction func done()
    {

        
        if let item = itemToEdit {
            item.text = textField.text!
            delegate?.addItemViewController(self, didFinishEditing: item)
        } else {
            let item = CheckListItem()
            item.text = textField.text!
            item.checked = false
            delegate?.addItemViewController(self, didFinishAdding: item)
        }
        
    }
    
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        return nil
    }
    override func viewDidLoad()
    {
        super.viewDidLoad()
        if let item = itemToEdit {
            textField.text = item.text
        }
    }
    
}

protocol  AddItemViewControllerDelegate: class
{
    func addItemViewControllerDidCancel(_ controller: AddItemViewController)
    
    func addItemViewController(_ controller: AddItemViewController, didFinishAdding item: CheckListItem)
    func addItemViewController(_ controller: AddItemViewController,
                               didFinishEditing item: CheckListItem)
}

