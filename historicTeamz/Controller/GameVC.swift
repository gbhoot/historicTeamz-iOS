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
    
    @IBOutlet weak var gkStackView: UIStackView!
    @IBOutlet weak var defStackView: UIStackView!
    @IBOutlet weak var defMidStackView: UIStackView!
    @IBOutlet weak var midStackView: UIStackView!
    @IBOutlet weak var attMidStackView: UIStackView!
    @IBOutlet weak var forStackView: UIStackView!
    
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
        print(pitchView.frame.origin.y)
        pitchView.bindToKeyboard()
        guard let teamData = self.team else {
            startSpinner()
            return
        }
        
        stopSpinner()
        self.pitchView.addBackground(imageName: IMG_PITCH_FULL)
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
        checkStarters()
    }
    
    func startSpinner() {
        spinner.startAnimating()
        spinnerView.isHidden = false
    }
    
    func stopSpinner() {
        spinner.stopAnimating()
        spinnerView.isHidden = true
    }
    
    func checkStarters() {
        guard let teamSingle = self.team else { return }
        let starters = teamSingle.starters as NSDictionary
        for (key, value) in starters {
            let player = value as! NSDictionary
            let pos = key as! String
            let dimension = gkStackView.frame.height * 0.7
            let button = UIButton(type: .custom)
//            button.frame = CGRect(x: 0, y: 0, width: dimension, height: dimension)
            button.bounds.size = CGSize(width: dimension, height: dimension)
            button.clipsToBounds = true
            button.layer.cornerRadius = 0.5 * button.bounds.size.width
            if let enabled = player["enabled"] as? Bool {
                if enabled {
                    button.backgroundColor = #colorLiteral(red: 0.3176470697, green: 0.07450980693, blue: 0.02745098062, alpha: 1)
                } else {
                    button.backgroundColor = #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)
                }
            }
            switch pos {
            case "gk":
                gkStackView.addSubview(button)
                break
            default:
                break
            }
        }
    }
    
    // IB-Actions
    @IBAction func backBtnPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
