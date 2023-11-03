//
//  ListDetailViewConrtoller.swift
//  ToDoList
//
//  Created by Moataz Mohamed on 02/11/2023.
//

import Foundation
import UIKit

protocol ListDetailViewConrtollerDelegate{
    func ListDetailViewConrtollerDidCancel(_ controller:ListDetailViewConrtoller)
    func listDetailViewConrtoller(_ controller:ListDetailViewConrtoller,didFinishAdding list:CheckListData)
    func listDetailViewConrtoller(_ controller:ListDetailViewConrtoller,didFinishEditing list:CheckListData)
    
}
class ListDetailViewConrtoller:UITableViewController{
    
    
    var listToEdit:CheckListData?
    var delegate:ListDetailViewConrtollerDelegate?
    @IBOutlet var textField:UITextField!
    @IBOutlet var doneBarButton:UIBarButtonItem!
    @IBOutlet var iconImage:UIImageView!
    @IBOutlet var iconLabel:UILabel!
    override func viewDidLoad() {
        textField.delegate=self
        
        navigationItem.largeTitleDisplayMode = .never
        textField.becomeFirstResponder()
        
        super.viewDidLoad()
        if let list=listToEdit{
            title="Edit List Name"
            textField.text=list.name
            doneBarButton.isEnabled=true
        }else{
            doneBarButton.isEnabled=false
        }
    }
    
//    MARK: - Actions
    
    @IBAction func done(){
        if let list=listToEdit{
            list.name=textField.text!
            delegate?.listDetailViewConrtoller(self, didFinishEditing: list)
        }else{
            let newList=CheckListData(name: textField.text!)
            delegate?.listDetailViewConrtoller(self, didFinishAdding: newList)
        }
    }
    @IBAction func cancel(){
        delegate?.ListDetailViewConrtollerDidCancel(self)
    }
    
    //    MARK: - Navigation
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if segue.identifier=="showIcons"{
                let controller=segue.destination as! IconPickerViewController
                controller.delegate=self
            }
        }

}


extension ListDetailViewConrtoller:UITextFieldDelegate{
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let oldText = textField.text!
        let stringRange = Range(range, in: oldText)!
        let newText = oldText.replacingCharacters(
            in: stringRange,
            with: string)
        doneBarButton.isEnabled = !newText.isEmpty
        return true
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        doneBarButton.isEnabled=false
        return true
    }
}


// MARK: - Icon Picker delegate

extension ListDetailViewConrtoller:IconPickerViewControllerDelegate{
    func iconPickerViewController(_ controller: IconPickerViewController, didFinishPicking icon: String) {
        iconLabel.text=icon
        iconImage.image=UIImage(named: icon)
        navigationController?.popViewController(animated: true)
    }
    
    
}