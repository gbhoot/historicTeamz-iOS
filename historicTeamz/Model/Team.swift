//
//  Team.swift
//  historicTeamz
//
//  Created by Gurpal Bhoot on 1/23/19.
//  Copyright © 2019 Gurpal Bhoot. All rights reserved.
//

import UIKit

struct Team {
    public private(set) var ftid: Any!
    public private(set) var game: String!
    public private(set) var season: Int!
    public private(set) var org: String!
    public private(set) var opposition: String!
    public private(set) var score: [Int]!
    public private(set) var home: Bool!
    public private(set) var starters: NSDictionary!
    public private(set) var bench: [NSDictionary]!
    
    init(ftid: Any, game: String, season: Int, org: String, opposition: String, score: [Int], home: Bool, starters: NSDictionary, bench: [NSDictionary]) {
        self.ftid = ftid
        self.game = game
        self.season = season
        self.org = org
        self.opposition = opposition
        self.score = score
        self.home = home
        self.starters = starters
        self.bench = bench
    }
}
