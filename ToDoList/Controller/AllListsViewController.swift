//
//  AllListsViewController.swift
//  ToDoList
//
//  Created by Moataz Mohamed on 02/11/2023.
//

import Foundation
import UIKit

class AllListsViewController:UITableViewController {
    
    var listsData=[CheckListData]()
    let listCellIdentfier = "listCell"
    override func viewDidLoad() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: listCellIdentfier)
        navigationController?.navigationBar.prefersLargeTitles = true
        super.viewDidLoad()
    }
    
    
    
//    MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier=="editList"{
            let controller=segue.destination as! ListDetailViewConrtoller
            controller.delegate=self
            if let indexPath=sender as? IndexPath{
                controller.listToEdit=listsData[indexPath.row]
            }
            
        }else if segue.identifier == "addList"{
            let controller=segue.destination as! ListDetailViewConrtoller
            controller.delegate=self
        }else if segue.identifier == "showItems"{
            let controller=segue.destination as! CheckListViewController
            controller.checkLists=sender as? CheckListData
        }
    }
    
}



// MARK: - Table view data source


extension AllListsViewController{

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return listsData.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: listCellIdentfier, for: indexPath)
        cell.textLabel?.text=listsData[indexPath.row].name
        cell.accessoryType = .detailDisclosureButton
        cell.imageView?.image=UIImage(named: listsData[indexPath.row].iconName)
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let checkLists=listsData[indexPath.row]
        performSegue(withIdentifier: "showItems", sender: checkLists)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        performSegue(withIdentifier: "editList", sender: indexPath)
    }
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let index=listsData.firstIndex(of: listsData[indexPath.row])!
        let indexPath=IndexPath(row: index, section: 0)
        listsData.remove(at: index)
        tableView.deleteRows(at: [indexPath], with: .automatic)
    }
    
}

// MARK: - ListDetailViewConrtoller delegate

extension AllListsViewController:ListDetailViewConrtollerDelegate{
    func ListDetailViewConrtollerDidCancel(_ controller: ListDetailViewConrtoller) {
        navigationController?.popViewController(animated: true)
    }
    
    func listDetailViewConrtoller(_ controller: ListDetailViewConrtoller, didFinishAdding list: CheckListData) {
        let index = listsData.count
        listsData.append(list)
        let indexPath=IndexPath(row: index, section: 0)
        tableView.insertRows(at: [indexPath], with: .automatic)
        navigationController?.popViewController(animated: true)
    }
    
    func listDetailViewConrtoller(_ controller: ListDetailViewConrtoller, didFinishEditing list: CheckListData) {
        let index = listsData.firstIndex(of: list)
        let indexPath=IndexPath(row: index!, section: 0)
        if let cell = tableView.cellForRow(at: indexPath){
            cell.textLabel?.text=list.name
            cell.imageView?.image=UIImage(named: list.iconName)
            
        }
        navigationController?.popViewController(animated: true)
    }
    
    
}
