//
//  ViewController.swift
//  ToDoList
//
//  Created by Moataz Mohamed on 31/10/2023.
//

import UIKit



class CheckListViewController: UITableViewController {
    var checkLists:CheckListData!
    override func viewDidLoad() {
        title=checkLists.name
        navigationItem.largeTitleDisplayMode = .never
    }
//    MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AddItem"{
            let controller = segue.destination as! ItemDetailViewController
            controller.delegate = self
        }
        else if segue.identifier == "EditItem"{
            let controller = segue.destination as! ItemDetailViewController
            controller.delegate=self
            if let indexPath=tableView.indexPath(for: sender as! UITableViewCell){
                controller.itemToEdit = checkLists.itemsList[indexPath.row]
            }
        }
        
    }
    
}

// MARK: - TableView Data Source

extension CheckListViewController{
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return checkLists.itemsList.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemsCell", for: indexPath) as! ItemCell
        configureCell(cell, item: checkLists.itemsList[indexPath.row])
        configureCheckMark(cell, item: checkLists.itemsList[indexPath.row])
        
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? ItemCell{
            checkLists.itemsList[indexPath.row].check.toggle()
            configureCheckMark(cell, item: checkLists.itemsList[indexPath.row])
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let indexRemoved=IndexPath(row: indexPath.row, section: 0)
        checkLists.itemsList.remove(at: indexPath.row)

        tableView.deleteRows(at: [indexRemoved], with: .automatic)
    }

    
}

// MARK: -  ItemDetailViewController Delegate

extension CheckListViewController:ItemDetailViewControllerDelegate{
    func ItemDetailViewControllerDidCancel(_ controller: ItemDetailViewController) {
        navigationController?.popViewController(animated: true)
    }
    
    func itemDetailViewController(_ controller: ItemDetailViewController, didFinishAdding item: ItemData) {
        let newIndex=checkLists.itemsList.count
        checkLists.itemsList.append(item)
        let indexPath=IndexPath(row: newIndex, section: 0)
        tableView.insertRows(at: [indexPath], with: .automatic)
        navigationController?.popViewController(animated: true)
    }
    func itemDetailViewController(_ controller: ItemDetailViewController, didFinishEditing item: ItemData) {
        if let index = checkLists.itemsList.firstIndex(of: item){
            let indexPath = IndexPath(row: index, section: 0)
            if let cell = tableView.cellForRow(at: indexPath){
                cell.textLabel?.text=item.text
            }
            navigationController?.popViewController(animated: true)
        }
    }
    
    
}
