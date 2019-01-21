//
//  RoundedButton.swift
//  historicTeamz
//
//  Created by Gurpal Bhoot on 1/18/19.
//  Copyright © 2019 Gurpal Bhoot. All rights reserved.
//

import UIKit

@IBDesignable
class RoundedButton: UIButton {

    override func awakeFromNib() {
        customizeView()
        
        super.awakeFromNib()
    }
    
    override func prepareForInterfaceBuilder() {
        customizeView()
    }
    
    func customizeView() {
        self.layer.cornerRadius = 15
    }
}
