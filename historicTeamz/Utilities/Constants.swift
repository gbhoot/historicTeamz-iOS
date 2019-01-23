//
//  Constants.swift
//  historicTeamz
//
//  Created by Gurpal Bhoot on 1/21/19.
//  Copyright © 2019 Gurpal Bhoot. All rights reserved.
//

import Foundation


// Completion Handlers
typealias CompletionHandStrings = (_ completion: Bool, _ strings: [String]) -> ()
typealias CompletionHandTeams = (_ completion: Bool, _ teams: [NSDictionary]) -> ()

// Database
let BASE_URL_FUTBAL                 =   "http://localhost:8000/db/v1/futbalTeams/"
let ALL_COUNTRIES                   =   "countries"
let ALL_ORGANIZATIONS               =   "organizations"
let ALL_TEAMS_BY_VIEWS              =   "views"

// Storyboard Segue IDs
let ID_SEGUE_TO_TEAM_LIST           =   "toTeamListVC"

// Cell Reuse IDs
let ID_REUSE_TEAM_CELL              =   "teamCell"
let ID_REUSE_CATEGORY_CELL          =   "categoryCell"

// Functions
func formURLAllOrganizations(for country: String) -> String {
    return ("countries/" + country + "/organizations")
}

func formURLAllTeams(for organization: String) -> String {
    return ("organizations/" + organization + "/teams")
}

// Defaults
let DEFAULT_TEAM_BADGE_LINK         =   "https://cdn0.iconfinder.com/data/icons/sports-98/64/sport-badge-emblem-shield-football-club-512.png"
