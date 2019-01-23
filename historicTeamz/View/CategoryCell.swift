//
//  CategoryCell.swift
//  historicTeamz
//
//  Created by Gurpal Bhoot on 1/22/19.
//  Copyright © 2019 Gurpal Bhoot. All rights reserved.
//

import UIKit

class CategoryCell: UITableViewCell {
    
    // IBOutlets
    @IBOutlet weak var indexLbl: UILabel!
    @IBOutlet weak var categoryLbl: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    // Functions
    func configureCell(category: String, index: Int) {
        indexLbl.text = "\(index)"
        categoryLbl.text = category
    }
}
