//
//  Player.swift
//  historicTeamz
//
//  Created by Gurpal Bhoot on 1/23/19.
//  Copyright © 2019 Gurpal Bhoot. All rights reserved.
//

import UIKit

struct Player {
    public private(set) var firstName: String!
    public private(set) var lastName: String!
    public private(set) var enabled: Bool!
    
    init(fName: String, lName: String, enabled: Bool) {
        firstName = fName
        lastName = lName
        self.enabled = enabled
    }
}
