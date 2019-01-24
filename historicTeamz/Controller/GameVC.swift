//
//  GameVC.swift
//  historicTeamz
//
//  Created by Gurpal Bhoot on 1/23/19.
//  Copyright © 2019 Gurpal Bhoot. All rights reserved.
//

import UIKit

class GameVC: UIViewController {
    
    // IBOutlets
    @IBOutlet weak var gameSeasonLbl: UILabel!
    @IBOutlet weak var homeTeamLbl: UILabel!
    @IBOutlet weak var homeScoreLbl: UILabel!
    @IBOutlet weak var awayScoreLbl: UILabel!
    @IBOutlet weak var awayTeamLbl: UILabel!
    @IBOutlet weak var pitchView: UIView!
    @IBOutlet weak var playerTxtField: UITextField!
    @IBOutlet weak var spinnerView: UIView!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    // Variables
    var ftid: String?
    var team: Team?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        downloadTeamData()
    }
    
    // Functions
    func downloadTeamData() {
        guard let team_id = ftid else {
            print("Shit went wrong")
            return
        }
        TeamService.instance.getSingleTeam(ftid: team_id) { (success, team) in
            if success {
                let _id = team["_id"] as Any
                let starters = team["starters"] as! NSDictionary
                let bench = team["bench"] as! [NSDictionary]
                let game = team["game"] as! String
                let season = team["season"] as! Int
                let organization = team["organization"] as! String
                let opposition = team["opposition"] as! String
                let home = team["home"] as! Bool
                let score = team["score"] as! [Int]
                self.team = Team(ftid: _id, game: game, season: season, org: organization, opposition: opposition, score: score, home: home, starters: starters, bench: bench)
                DispatchQueue.main.async {
                    self.setupView()
                }
            }
        }
    }
    
    func setupView() {
//        pitchView.backgroundColor = UIColor(patternImage: UIImage(named: IMG_PITCH)!)
        guard let teamData = self.team else {
            startSpinner()
            return
        }
        
        stopSpinner()
        DispatchQueue.main.async {
            self.pitchView.addBackground(imageName: IMG_PITCH)
            let season = teamData.season as Int
            self.gameSeasonLbl.text = teamData.game + " \(season)-\(season + 1)"
            if teamData.home {
                self.homeTeamLbl.text = teamData.org
                self.homeScoreLbl.text = "\(teamData.score[0])"
                self.homeTeamLbl.textColor = #colorLiteral(red: 0.1294117719, green: 0.2156862766, blue: 0.06666667014, alpha: 1)
                self.homeScoreLbl.textColor = #colorLiteral(red: 0.1294117719, green: 0.2156862766, blue: 0.06666667014, alpha: 1)
                self.awayScoreLbl.text = "\(teamData.score[1])"
                self.awayTeamLbl.text = teamData.opposition
            } else {
                self.homeTeamLbl.text = teamData.opposition
                self.homeScoreLbl.text = "\(teamData.score[1])"
                self.awayScoreLbl.text = "\(teamData.score[0])"
                self.awayTeamLbl.text = teamData.org
                self.awayTeamLbl.textColor = #colorLiteral(red: 0.1294117719, green: 0.2156862766, blue: 0.06666667014, alpha: 1)
                self.awayScoreLbl.textColor = #colorLiteral(red: 0.1294117719, green: 0.2156862766, blue: 0.06666667014, alpha: 1)
            }
            
        }
    }
    
    func startSpinner() {
        spinner.startAnimating()
        spinnerView.isHidden = false
    }
    
    func stopSpinner() {
        spinner.stopAnimating()
        spinnerView.isHidden = true
    }
    
    // IB-Actions
    @IBAction func backBtnPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
