//
//  ItemCell.swift
//  ToDoList
//
//  Created by Moataz Mohamed on 31/10/2023.
//

import UIKit

class ItemCell: UITableViewCell {
    
    @IBOutlet var checkMark:UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    

    override func layoutSubviews() {
        super.layoutSubviews()
        textLabel?.frame.origin.x += 20
    }
}
