//
//  ReviewTableCell.swift
//  Rapin001Team-iRate
//
//  Created by Rolans Apinis on 7/28/20.
//  Copyright © 2020 Rolans Apinis. All rights reserved.
//

import UIKit

class ReviewTableCell: UITableViewCell {
    
    //Add text field outlets
    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var category: UILabel!
    @IBOutlet weak var score: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        title.text = ""
        category.text = ""
        score.text = ""
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
