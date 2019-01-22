//
//  TeamCell.swift
//  historicTeamz
//
//  Created by Gurpal Bhoot on 1/21/19.
//  Copyright © 2019 Gurpal Bhoot. All rights reserved.
//

import UIKit

class TeamCell: UITableViewCell {
    
    // IBOutlets
    @IBOutlet weak var badgeImgView: UIImageView!
    @IBOutlet weak var organizationLbl: UILabel!
    @IBOutlet weak var seasonGameLbl: UILabel!
    @IBOutlet weak var viewsLbl: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    // Functions
    func configureCell(badgeLink: String, organization: String, season: Int, game: String, views: Int) {
        self.badgeImgView.downloaded(from: badgeLink)
        organizationLbl.text = organization
        seasonGameLbl.text = "\(season)-\(season + 1) \(game)"
        viewsLbl.text = "\(views) views"
    }
}
