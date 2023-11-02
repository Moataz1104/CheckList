//
//  HelperMethods.swift
//  ToDoList
//
//  Created by Moataz Mohamed on 02/11/2023.
//

import Foundation
import UIKit

func configureCheckMark(_ cell:UITableViewCell , item:ItemData){
    let cell = cell as! ItemCell
    if item.check == false{
        cell.checkMark.text="✓"
        item.check.toggle()
    }else{
        cell.checkMark.text=""
        item.check.toggle()
    }
    
}

func configureCell(_ cell:UITableViewCell , item:ItemData){
    let cell = cell as! ItemCell
    cell.textLabel?.text=item.text
    cell.checkMark.text=""
}
