//
//  ItemDetailViewController.swift
//  ToDoList
//
//  Created by Moataz Mohamed on 31/10/2023.
//

import UIKit

protocol ItemDetailViewControllerDelegate:AnyObject{
    func ItemDetailViewControllerDidCancel(_ controller:ItemDetailViewController)
    func itemDetailViewController(_ controller:ItemDetailViewController,didFinishAdding item : ItemData)
    func itemDetailViewController(_ controller:ItemDetailViewController,didFinishEditing item:ItemData)
}

class ItemDetailViewController:UITableViewController{
    @IBOutlet var textField:UITextField!
    @IBOutlet var doneBarButton:UIBarButtonItem!
    weak var delegate:ItemDetailViewControllerDelegate?
    var itemToEdit:ItemData?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let item = itemToEdit {
            title = "Edit Item"
            textField.text=item.text
            doneBarButton.isEnabled = true
        }
        
        textField.delegate=self
        navigationItem.largeTitleDisplayMode = .never
        
    }
    override func viewWillAppear(_ animated: Bool) {
      super.viewWillAppear(animated)
      textField.becomeFirstResponder()
    }
    
    
//    MARK: - Actions
    
    @IBAction func done(){
        if let itemToEdit=itemToEdit{
            itemToEdit.text=textField.text!
            delegate?.itemDetailViewController(self, didFinishEditing: itemToEdit)
        }else{
            let item=ItemData()
            item.text=textField.text!
            delegate?.itemDetailViewController(self, didFinishAdding:item)
        }
    }
    @IBAction func cancel(){
        delegate?.ItemDetailViewControllerDidCancel(self)
    }
}


extension ItemDetailViewController:UITextFieldDelegate{
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
