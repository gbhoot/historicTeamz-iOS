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
    var teamsByViews: [NSDictionary]?
    var countries: [String]?
    var organizations: [String]?
    var teamsInOrg: [NSDictionary]?
    
    var state: ListState = .popular
    
    var selectedCountryIdx: Int = -1
    var selectedOrgIdx: Int = -1
    var selectedTeamIdx: Int = -1

    // Constants
    let teamRowHeight: CGFloat = 100
    let teamRowHeightSelected: CGFloat = 200
    let categoryRowHeight: CGFloat = 50
    
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
                self.teamsByViews = teams
                DispatchQueue.main.async {
                    self.teamListTblView.reloadData()
                }
            }
        }
        TeamService.instance.getAllCountries { (success, countries) in
            if success {
                self.countries = countries
                DispatchQueue.main.async {
                    self.teamListTblView.reloadData()
                }
            }
        }
    }
    
    func downloadOrganizationsFromDB(country: String) {
        TeamService.instance.getAllOrganizations(for: country) { (success, organizations) in
            if success {
                self.organizations = organizations
                DispatchQueue.main.async {
                    self.teamListTblView.reloadData()
                }
            }
        }
    }
    
    func downloadTeamsFromDB(org: String) {
        TeamService.instance.getAllTeams(for: org) { (success, teams) in
            if success {
                self.teamsInOrg = teams
                DispatchQueue.main.async {
                    self.teamListTblView.reloadData()
                }
            }
        }
    }
    
    // IB-Actions
    @IBAction func segmentedValueDidChange(_ sender: Any) {
        guard let sending = sender as? UISegmentedControl else { return }
        let idx = sending.selectedSegmentIndex
        switch idx {
        case 0:
            state = .popular
            break
        case 1:
            state = .all
            break
        default:
            state = .popular
            break
        }
        
        self.selectedTeamIdx = -1
        self.selectedCountryIdx = -1
        self.selectedOrgIdx = -1
        self.teamListTblView.reloadData()
    }
}

extension TeamListVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        switch state {
        case .popular:
            return 1
        default:
            if selectedOrgIdx > -1 {
                return 3
            } else if selectedCountryIdx > -1 {
                return 2
            }

            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch state {
        case .popular:
            guard let teamList = self.teamsByViews else { return 0 }
            return teamList.count
        default:
            if section == 0 {
                guard let countryList = self.countries else { return 0 }
                return countryList.count
            } else if section == 1 {
                guard let orgList = self.organizations else { return 0 }
                return orgList.count
            } else {
                guard let teamList = self.teamsInOrg else { return 0 }
                return teamList.count
            }
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch state {
        case .popular:
            guard let teamList = self.teamsByViews, let cell = tableView.dequeueReusableCell(withIdentifier: ID_REUSE_TEAM_CELL, for: indexPath) as? TeamCell else { return UITableViewCell() }
            let team = teamList[indexPath.row]
            let team_id = team["_id"] as! String
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

            cell.configureCell(badgeLink: badgeLink, organization: organization, season: season, game: game, views: views, team_id: team_id)
            if selectedTeamIdx == indexPath.row {
                cell.playBtn.isHidden = false
            } else {
                cell.playBtn.isHidden = true
            }


            return cell
        case .all:
            if indexPath.section == 0 {
                guard let countryList = self.countries, let cell = tableView.dequeueReusableCell(withIdentifier: ID_REUSE_CATEGORY_CELL, for: indexPath) as? CategoryCell else { return UITableViewCell() }
                
                cell.configureCell(category: countryList[indexPath.row], index: indexPath.row + 1)
                
                return cell
            } else if indexPath.section == 1 {
                guard let orgList = self.organizations, let cell = tableView.dequeueReusableCell(withIdentifier: ID_REUSE_CATEGORY_CELL, for: indexPath) as? CategoryCell else { return UITableViewCell() }
                
                cell.configureCell(category: orgList[indexPath.row], index: indexPath.row + 1)
                
                return cell
            } else {
                guard let teamList = self.teamsInOrg, let cell = tableView.dequeueReusableCell(withIdentifier: ID_REUSE_TEAM_CELL, for: indexPath) as? TeamCell else { return UITableViewCell() }
                
                let team = teamList[indexPath.row]
                let team_id = team["_id"] as! String
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
                
                cell.configureCell(badgeLink: badgeLink, organization: organization, season: season, game: game, views: views, team_id: team_id)
                if selectedTeamIdx == indexPath.row {
                    cell.playBtn.isHidden = false
                } else {
                    cell.playBtn.isHidden = true
                }

                return cell
            }
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        var height: CGFloat
        
        switch state {
        case .popular:
            if selectedTeamIdx == indexPath.row {
                height = teamRowHeightSelected
            } else {
                height = teamRowHeight
            }
        default:
            if indexPath.section == 2 {
                if selectedTeamIdx == indexPath.row {
                    height = teamRowHeightSelected
                } else {
                    height = teamRowHeight
                }
            } else {
                height = categoryRowHeight
            }
        }
        
        return height
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch state {
        case .popular:
            alterTeamCell(tableView: tableView, indexPath: indexPath)
            break
        default:
            if indexPath.section == 0 {
                selectedCountryIdx = indexPath.row
                selectedOrgIdx = -1
                guard let countryList = countries else { return }
                let country = countryList[indexPath.row]
                self.downloadOrganizationsFromDB(country: country)
            } else if indexPath.section == 1 {
                selectedOrgIdx = indexPath.row
                guard let orgList = organizations else { return }
                let org = orgList[indexPath.row]
                self.downloadTeamsFromDB(org: org)
            } else {
                alterTeamCell(tableView: tableView, indexPath: indexPath)
            }
            
            break
        }
        
        teamListTblView.reloadData()
    }
    
    // Functions
    func alterTeamCell(tableView: UITableView, indexPath: IndexPath) {
        if (self.selectedTeamIdx == indexPath.row) {
            self.selectedTeamIdx = -1
        } else {
            self.selectedTeamIdx = indexPath.row
        }
    }
}
