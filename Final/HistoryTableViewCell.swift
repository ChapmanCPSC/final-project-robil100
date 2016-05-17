//
//  HistoryTableViewCell.swift
//  Final
//
//  Created by Matt on 5/14/16.
//  Copyright © 2016 Robillard, Matt. All rights reserved.
//

import UIKit

class HistoryTableViewCell: UITableViewCell {
    
    @IBOutlet weak var cellNameLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func initResult(result : Result)
    {
        self.cellNameLabel.text = result.date
    }
    
}
