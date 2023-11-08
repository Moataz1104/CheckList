//
//  CheckListData.swift
//  ToDoList
//
//  Created by Moataz Mohamed on 31/10/2023.
//

import UIKit

class CheckListData:Equatable,Codable {
    static func == (lhs: CheckListData, rhs: CheckListData) -> Bool {
        lhs.name==rhs.name
    }
    var name:String=""
    var itemsList:[ItemData]=[]
    var iconName="Folder"
    init(name: String) {
        self.name = name
        
    }
    
    func countUnChecked() -> Int{
        if itemsList.count == 0{
            return -1
        }
        var cn = 0
        for item in itemsList where !item.check {
            cn += 1
        }
        return cn
    }
    
    func cellSubtitle() -> String{
        var cn = countUnChecked()
        var text=""
        switch cn{
        case 0:
            text = "All Done!"
        case -1:
            text = "No Items"
        case 1:
            text = "1 Item left"
        default:
            text = "\(cn) Items left"
        }
        
        
        return text
    }
    
    
}

