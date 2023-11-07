//
//  ItemData.swift
//  ToDoList
//
//  Created by Moataz Mohamed on 31/10/2023.
//


class ItemData:Equatable,Codable{
    static func == (lhs: ItemData, rhs: ItemData) -> Bool {
        return lhs.text == rhs.text
    }
    
    var text=""
    var check=false
}
