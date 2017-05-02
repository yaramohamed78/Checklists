//
//  AddListTableViewController.swift
//  CheckLists
//
//  Created by yara mohamed on 4/28/17.
//  Copyright © 2017 yara mohamediCode. All rights reserved.
//

import UIKit

class AddListViewController: UITableViewController , IconsViewControllerDelegate
{
    var delegate : AddListViewControllerDelegate!
    var listToEdit : CheckList?
    var iconChosen = Icon()
    
    @IBOutlet weak var iconImage: UIImageView!
    @IBOutlet weak var iconTitle: UILabel!
    @IBOutlet weak var listTextField: UITextField!
    
    @IBAction func cancel(_ sender: UIBarButtonItem)
    {

        delegate?.addListViewControllerDidCancel(self)
    }
    
    
    @IBAction func done(_ sender: UIBarButtonItem)
    {
        
        if let list = listToEdit
        {
            list.title = listTextField.text!
            list.icon = iconChosen.image
            print("Edit")
            delegate?.addListViewController(self, didFinishEditing: list)
        }
        else
        {
            let list = CheckList()
            list.title = listTextField.text!
            list.items = []
            list.icon  = iconChosen.image
            delegate?.addListViewController(self, didFinishAdding: list)
        
        }
        
    }

    override func viewDidLoad()
    {
        
        super.viewDidLoad()
        if let list = listToEdit
        {
            listTextField.text = list.title
            iconImage.image = list.icon
            
        }

    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    
    func iconsViewControllerDelegate(_ controller: IconsViewController , didFinishAdding item: Icon )
    {
        iconChosen = item
        iconTitle.text = item.description
        iconImage.image = item.image
    }
    
    func iconsViewControllerDelegate(_ controller: IconsViewController , didFinishEditing item: Icon )
    {
        
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.identifier == "ChooseIcon"
        {
             let controller = segue.destination as! IconsViewController
            
            controller.delegate = self
            
        }

    }
}


protocol  AddListViewControllerDelegate : class
{
    func addListViewControllerDidCancel(_ controller : AddListViewController)
    
    func addListViewController(_ controller : AddListViewController , didFinishAdding list : CheckList)
    func addListViewController(_ controller : AddListViewController , didFinishEditing list : CheckList)
}
