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
}

class ItemDetailViewController:UITableViewController{
    @IBOutlet var textField:UITextField!
    @IBOutlet var doneBarButton:UIBarButtonItem!
    weak var delegate:ItemDetailViewControllerDelegate?
    
    override func viewDidLoad() {
        textField.delegate=self
        navigationItem.largeTitleDisplayMode = .never

        textField.becomeFirstResponder()
        super.viewDidLoad()
        
    }
    
    
//    MARK: - Actions
    
    @IBAction func done(){
        let item=ItemData()
        item.text=textField.text!
        delegate?.itemDetailViewController(self, didFinishAdding:item)
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
