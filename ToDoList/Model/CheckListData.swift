//
//  CheckListData.swift
//  ToDoList
//
//  Created by Moataz Mohamed on 31/10/2023.
//

import UIKit
import Foundation

class CheckListData:Equatable {
    static func == (lhs: CheckListData, rhs: CheckListData) -> Bool {
        lhs.name==rhs.name
    }
    var name:String=""
    var itemsList:[ItemData]=[]
    var iconName="No Folder"
    init(name: String) {
        self.name = name
    }

    

}
