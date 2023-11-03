//
//  IconPickerViewController.swift
//  ToDoList
//
//  Created by Moataz Mohamed on 03/11/2023.
//

import Foundation
import UIKit

protocol IconPickerViewControllerDelegate{
    func iconPickerViewController(_ controller:IconPickerViewController,didFinishPicking icon:String)
}

class IconPickerViewController:UITableViewController{
    
    var delegate:IconPickerViewControllerDelegate?
    let iconList=["No Icon","Appointments","Birthdays","Chores","Drinks","Groceries","Inbox","Trips","Photos"]
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    
    
    
    
}

// MARK: - Table View Data Source

extension IconPickerViewController{
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return iconList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "iconCell", for: indexPath)
        cell.textLabel?.text=iconList[indexPath.row]
        cell.imageView?.image=UIImage(named: iconList[indexPath.row])
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.iconPickerViewController(self, didFinishPicking: iconList[indexPath.row])
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
}



