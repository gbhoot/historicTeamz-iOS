//
//  TeamListVC.swift
//  historicTeamz
//
//  Created by Gurpal Bhoot on 1/21/19.
//  Copyright © 2019 Gurpal Bhoot. All rights reserved.
//

import UIKit

class TeamListVC: UIViewController {
    
    // IBOutlets
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var segmented: UISegmentedControl!
    @IBOutlet weak var teamListTblView: UITableView!
    
    // Variables
    var titleText: String?
    var teams: [NSDictionary]?

    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        setupTable()
        downloadDataFromDB()
    }
    
    // Functions
    func setupView() {
        if let title = titleText {
            titleLbl.text = title
        }
    }
    
    func setupTable() {
        teamListTblView.delegate = self
        teamListTblView.dataSource = self
    }
    
    func downloadDataFromDB() {
        TeamService.instance.getAllTeamsByViews { (success, teams) in
            if success {
                self.teams = teams
                DispatchQueue.main.async {
                    self.teamListTblView.reloadData()
                }
            }
        }
    }
}

extension TeamListVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let teamList = self.teams else { return 0 }
        return teamList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let teamList = self.teams, let cell = tableView.dequeueReusableCell(withIdentifier: ID_REUSE_TEAM_CELL, for: indexPath) as? TeamCell else { return UITableViewCell() }
        let team = teamList[indexPath.row]
        print(team)
        var badgeLink = DEFAULT_TEAM_BADGE_LINK
        if let badge = team["badge"] as? String {
            badgeLink = badge
        }
        let organization = team["organization"] as! String
        let season = team["season"] as! Int
        let game = team["game"] as! String
        var views: Int = 0
        if let viewings = team["views"] as? Int {
            views = viewings
        }
        cell.configureCell(badgeLink: badgeLink, organization: organization, season: season, game: game, views: views)
        
        return cell
    }
}
