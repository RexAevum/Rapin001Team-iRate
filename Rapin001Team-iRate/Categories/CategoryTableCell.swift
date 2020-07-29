//
//  CategoryTableCell.swift
//  Rapin001Team-iRate
//
//  Created by Rolans Apinis on 7/28/20.
//  Copyright © 2020 Rolans Apinis. All rights reserved.
//

import UIKit

class CategoryTableCell: UITableViewCell, UITextFieldDelegate {
    
    //fields
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var descriptionField: UITextField!
    @IBOutlet weak var count: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        name.text = ""
        descriptionField.text = ""
        count.text = ""
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    //MARK:- Text Field
    

}
