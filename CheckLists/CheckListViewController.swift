//
//  CheckListViewController.swift
//  CheckLists
//
//  Created by yara mohamed on 4/28/17.
//  Copyright © 2017 yara mohamediCode. All rights reserved.
//

import UIKit

var listObject : CheckList! = nil
class CheckListViewController: UITableViewController , AddListViewControllerDelegate
{
    var checkLists : [CheckList]
    var checkList : CheckList?
    
    required init?(coder aDecoder: NSCoder)
    {
        checkLists = []

        
        checkLists = [CheckList]()
        super.init(coder: aDecoder)
        loadChecklist()
        
    }

    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("11")
        let cell = tableView.dequeueReusableCell(withIdentifier: "CheckList", for: indexPath) as! CheckListCell
        let checkList = checkLists[indexPath.row]
        configureText(for: cell, with: checkList)
        configureImage(for: cell , with: checkList)
        configureItemsCount(for: cell , with: checkList)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return checkLists.count
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        checkLists.remove(at: indexPath.row)
        let indexPaths = [indexPath]
        tableView.deleteRows(at: indexPaths, with: .automatic)
//        saveChecklist()
    }
    

    
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        listObject = checkLists[indexPath.row]
//        saveChecklist()
    }
    
    @IBAction func add(_ sender: UIBarButtonItem)
    {
        print ("Here")
        let newRow = checkLists.count
        let list = CheckList()
        list.icon = #imageLiteral(resourceName: "No Icon")
        list.title = "Test Item"
        checkLists.append(list)
        let indexPath = IndexPath(row : newRow , section : 0)
        let indexPaths = [indexPath]
        tableView.insertRows(at: indexPaths, with: .automatic)
    }
    
    func addListViewControllerDidCancel(_ controller : AddListViewController)
    {
        
        dismiss(animated: true, completion: nil)
    }
    func addListViewController(_ controller : AddListViewController , didFinishAdding list : CheckList)
    {
        let newRow = checkLists.count
        checkLists.append(list)
        let indexPath = IndexPath(row: newRow, section: 0)
        let indexPaths = [indexPath]
        tableView.insertRows(at: indexPaths, with: .automatic)
//        saveChecklist()
        dismiss(animated: true, completion: nil)
        
    }
    func addListViewController(_ controller : AddListViewController , didFinishEditing list : CheckList)
    {
        if let index = checkLists.index(of : list)
        {
            let indexPath = IndexPath(row: index, section: 0)
            if let cell = tableView.cellForRow(at: indexPath)
            {
                configureText(for: cell as! CheckListCell, with: list)
                configureImage(for: cell as! CheckListCell, with: list)
            }
        }
//        saveChecklist()
        dismiss(animated: true, completion: nil)
        
    }
    
//    if let index = items.index(of: item) {
//        let indexPath = IndexPath(row: index, section: 0)
//        if let cell = tableView.cellForRow(at: indexPath)  {
//            configureText(for: cell as! CheckListItemCell, with: item)
//        }
//    }
    
    func configureText(for cell: CheckListCell , with item : CheckList)
    {
          let label   = cell.checkListTitle
          label?.text = item.title
//        let label = cell.itemTitleLabel
//        label?.text = item.text
        
    }
    
    func configureImage(for cell: CheckListCell , with item : CheckList)
    {
        let icon = cell.listIcon
        icon?.image = item.icon
    
    }
    func configureItemsCount(for cell: CheckListCell , with item : CheckList)
    {
        let noOfItems = cell.itemsCount
        noOfItems?.text = String(item.items.count)
        print(item.items.count)
        print("TEST")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.identifier == "AddListViewController"
        {
            if let navigationController = segue.destination as?UINavigationController
            {
                let controller = navigationController.topViewController as! AddListViewController
                controller.delegate = self
            
            }
        }
        else if segue.identifier ==  "editList"
        {
            if let navigationController = segue.destination as? UINavigationController
            {
                let controller = navigationController.topViewController
                as! AddListViewController
                controller.delegate = self
                if let indexPath = tableView.indexPath(for: sender as! UITableViewCell)
                {
                    controller.listToEdit = checkLists[indexPath.row]
                }
                

                }
            }
        
        
        else if segue.identifier == "ViewCheckListItems"
        {
        let controller = segue.destination as! CheckListItemViewController
    if let indexPath = tableView.indexPath(for: sender as! UITableViewCell)
    {
                let cell = tableView.dequeueReusableCell(withIdentifier: "CheckList", for: indexPath) as! CheckListCell
        let tempList = checkLists[indexPath.row]
       configureItemsCount(for: cell , with: tempList)
    }
//
        }
    }
 
    
    func documentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    func dataFilePath() -> URL {
        return documentsDirectory().appendingPathComponent("Checklist.plist")
    }
    
    func saveChecklist() {
        let data = NSMutableData()
        let archiver = NSKeyedArchiver(forWritingWith: data)
        archiver.encode(checkLists, forKey: "CheckLists")
        archiver.finishEncoding()
        data.write(to: dataFilePath(), atomically: true)
    }
    
    func loadChecklist() {
        //1
        let path = dataFilePath()
        // 2
        if let data = try? Data(contentsOf: path) {
            // 3
            let unarchiver = NSKeyedUnarchiver(forReadingWith: data)
            checkLists = unarchiver.decodeObject(forKey: "CheckLists") as! [CheckList]
            unarchiver.finishDecoding()
        }
    }
    



}

//protocol CheckListViewControllerDelegate : class
//{
//    func ShowCheckListItems(_ controller : CheckListViewController)
//}
