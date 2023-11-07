//
//  DataModel.swift
//  ToDoList
//
//  Created by Moataz Mohamed on 07/11/2023.
//

import Foundation

class DataModel{
    
    var lists=[CheckListData]()
    
    
    init(){
        loadCheckList()
    }
    
//    MARK: - Save & Load
    
    func documentPath()->URL{
        let docUrl=FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return docUrl[0]
    }
    func dataFilePath()->URL{
        return documentPath().appendingPathComponent("ToDoList.plist")
    }
    
    func saveCheckList(){
        let encoder=PropertyListEncoder()
        do{
            let data = try encoder.encode(lists)
            try data.write(to: dataFilePath(),options: .atomic)
        }catch{
            print("error : \(error.localizedDescription)")
        }
    }
    func loadCheckList(){
        let path = dataFilePath()
        let decoder=PropertyListDecoder()
        do{
            let data = try Data(contentsOf: path)
            lists=try decoder.decode([CheckListData].self, from: data)
        }catch{
            print("error : \(error.localizedDescription)")

        }
    }
}
