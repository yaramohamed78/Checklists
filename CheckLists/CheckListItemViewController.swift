//
//  ViewController.swift
//  CheckLists
//
//  Created by yara mohamed on 4/23/17.
//  Copyright © 2017 yara mohamediCode. All rights reserved.
//

import UIKit

class CheckListItemViewController: UITableViewController , AddItemViewControllerDelegate
{
    var items : [CheckListItem]
    var checkList : CheckList!
    
  
        required init?(coder aDecoder: NSCoder)
        {
            items = [CheckListItem]()
            super.init(coder: aDecoder)
            loadChecklistItems()
        
          }

    override func viewDidLoad()
    {
        super.viewDidLoad()
        items = listObject.items
        
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CheckListItem" , for: indexPath) as! CheckListItemCell
        let item = items[indexPath.row]

        
        configureCheckmark(for: cell, with: item)
        configureText(for: cell, with: item)
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        if let cell = tableView.cellForRow(at: indexPath)
        {
            let item = items[indexPath.row]
            item.toggleChecked()
            configureCheckmark(for: cell as! CheckListItemCell, with : item)

        }
        tableView.deselectRow(at: indexPath, animated: true)
        saveChecklistItems()
    }
    

    
    func configureCheckmark(for cell: CheckListItemCell , with item : CheckListItem)
    {
        let checkMark = cell.checkMarkLabel
        if item.checked
        {
            checkMark?.text = "✔️"
        }
        else
        {
            checkMark?.text = ""
        }

    }
    
    func configureText(for cell: CheckListItemCell , with item : CheckListItem)
    {
        let label = cell.itemTitleLabel
        label?.text = item.text
        
    }
    

//    @IBAction func addItem(_ sender: UIBarButtonItem)
//    {
//        let newRowIndex = items.count
//        
//        let item = CheckListItem()
//        item.text = "I am a new row"
//        item.checked = false
//        items.append(item)
//        
//        let indexPath = IndexPath(row: newRowIndex, section: 0)
//        let indexPaths = [indexPath]
//        tableView.insertRows(at: indexPaths, with: .automatic)
//    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
            items.remove(at: indexPath.row)
        
            let indexPaths = [indexPath]
            tableView.deleteRows(at: indexPaths, with: .automatic)
            listObject.items = items
            saveChecklistItems()
        }
    func addItemViewControllerDidCancel(
        _ controller: AddItemViewController) {
        dismiss(animated: true, completion: nil)
    }
    func addItemViewController(_ controller: AddItemViewController,
                               didFinishAdding item: CheckListItem)
    {
        let newRowIndex = items.count
        items.append(item)
        listObject.items = items
        let indexPath = IndexPath(row: newRowIndex, section: 0)
        let indexPaths = [indexPath]
        tableView.insertRows(at: indexPaths, with: .automatic)
        saveChecklistItems()
        dismiss(animated: true, completion: nil)
    }
    
    func addItemViewController(_ controller: AddItemViewController,
                               didFinishEditing item: CheckListItem) {
        if let index = items.index(of: item) {
            let indexPath = IndexPath(row: index, section: 0)
            if let cell = tableView.cellForRow(at: indexPath)  {
                configureText(for: cell as! CheckListItemCell, with: item)
            }
        }
        saveChecklistItems()
        dismiss(animated: true, completion: nil)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.identifier == "AddItemViewController"
        {
            print ("HELLO")
            if let navigationController = segue.destination as? UINavigationController
            {
                let controller = navigationController.topViewController! as! AddItemViewController
                controller.delegate = self
            }
        }
        else if segue.identifier == "EditItem"
        {
            if let navigationController = segue.destination as? UINavigationController
            {
                let controller = navigationController.topViewController! as! AddItemViewController
                controller.delegate = self
                if let indexPath = tableView.indexPath(
                    for: sender as! UITableViewCell) {
                    controller.itemToEdit = items[indexPath.row]
                }
            }
        }
        else if segue.identifier == "ViewCheckListItems"
        {
            print ("Here")
        }
    }
    
    func documentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    func dataFilePath() -> URL {
        return documentsDirectory().appendingPathComponent("Checklists.plist")
    }
    
    func saveChecklistItems() {
        let data = NSMutableData()
        let archiver = NSKeyedArchiver(forWritingWith: data)
        archiver.encode(items, forKey: "CheckListItems")
        archiver.finishEncoding()
        data.write(to: dataFilePath(), atomically: true)
    }
    
    func loadChecklistItems() {
        //1
        let path = dataFilePath()
        // 2
        if let data = try? Data(contentsOf: path) {
            // 3
            let unarchiver = NSKeyedUnarchiver(forReadingWith: data)
            items = unarchiver.decodeObject(forKey: "CheckListItems") as! [CheckListItem]
            unarchiver.finishDecoding()
        }
    }
}

