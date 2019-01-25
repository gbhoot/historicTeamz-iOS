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
    
    @IBOutlet weak var playerStackView: UIStackView!
    @IBOutlet weak var gkStackView: UIStackView!
    @IBOutlet weak var defStackView: UIStackView!
    @IBOutlet weak var defMidStackView: UIStackView!
    @IBOutlet weak var midStackView: UIStackView!
    @IBOutlet weak var attMidStackView: UIStackView!
    @IBOutlet weak var forStackView: UIStackView!
    
    @IBOutlet weak var gkView: UIView!
    @IBOutlet weak var rbView: UIView!
    @IBOutlet weak var rcbView: UIView!
    @IBOutlet weak var cbView: UIView!
    @IBOutlet weak var lcbView: UIView!
    @IBOutlet weak var lbView: UIView!
    @IBOutlet weak var rwbView: UIView!
    @IBOutlet weak var rcdmView: UIView!
    @IBOutlet weak var cdmView: UIView!
    @IBOutlet weak var lcdmView: UIView!
    @IBOutlet weak var lwbView: UIView!
    @IBOutlet weak var rmView: UIView!
    @IBOutlet weak var rcmView: UIView!
    @IBOutlet weak var cmView: UIView!
    @IBOutlet weak var lcmView: UIView!
    @IBOutlet weak var lmView: UIView!
    @IBOutlet weak var rwView: UIView!
    @IBOutlet weak var ramView: UIView!
    @IBOutlet weak var camView: UIView!
    @IBOutlet weak var lamView: UIView!
    @IBOutlet weak var lwView: UIView!
    @IBOutlet weak var strView: UIView!
    @IBOutlet weak var cfView: UIView!
    @IBOutlet weak var stlView: UIView!
    
    // Variables
    var ftid: String?
    var team: Team?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        pitchView.bindToKeyboard()
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
                let starters = team["starters"] as! NSMutableDictionary
                let bench = team["bench"] as! [NSMutableDictionary]
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
        endEditing()
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
    
    func endEditing() {
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:))))
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
        removeAllPlayers()
        guard let teamSingle = self.team else { return }
        let starters = teamSingle.starters as NSMutableDictionary
        for (key, value) in starters {
            let player = value as! NSMutableDictionary
            let pos = key as! String
            let playerCirView: UIView = UIView()
            var colorBack = UIColor.gray
            if let enabled = player["enabled"] as? Bool {
                if enabled {
                    colorBack = UIColor.red
                }
            }
            let dimension = gkStackView.frame.height
            
            switch pos {
            case "gk":
                let width = gkView.frame.width / 2
                playerCirView.frame = CGRect(x: width - (dimension / 2), y: 0, width: dimension, height: dimension)
                playerCirView.asCircle(color: colorBack)
                gkView.addSubview(playerCirView)
                gkView.isHidden = false
                break
            case "rb":
                let width = rbView.frame.width / 2
                playerCirView.frame = CGRect(x: width - (dimension / 2), y: 0, width: dimension, height: dimension)
                playerCirView.asCircle(color: colorBack)
                rbView.addSubview(playerCirView)
                rbView.isHidden = false
            case "rcb":
                let width = rbView.frame.width / 2
                playerCirView.frame = CGRect(x: width - (dimension / 2), y: 0, width: dimension, height: dimension)
                playerCirView.asCircle(color: colorBack)
                rcbView.addSubview(playerCirView)
                rcbView.isHidden = false
            case "cb":
                let width = cbView.frame.width / 2
                playerCirView.frame = CGRect(x: width - (dimension / 2), y: 0, width: dimension, height: dimension)
                playerCirView.asCircle(color: colorBack)
                cbView.addSubview(playerCirView)
                cbView.isHidden = false
            case "lcb":
                let width = lcbView.frame.width / 2
                playerCirView.frame = CGRect(x: width - (dimension / 2), y: 0, width: dimension, height: dimension)
                playerCirView.asCircle(color: colorBack)
                lcbView.addSubview(playerCirView)
                lcbView.isHidden = false
            case "lb":
                let width = lbView.frame.width / 2
                playerCirView.frame = CGRect(x: width - (dimension / 2), y: 0, width: dimension, height: dimension)
                playerCirView.asCircle(color: colorBack)
                lbView.addSubview(playerCirView)
                lbView.isHidden = false
            case "rwb":
                let width = rwbView.frame.width / 2
                playerCirView.frame = CGRect(x: width - (dimension / 2), y: 0, width: dimension, height: dimension)
                playerCirView.asCircle(color: colorBack)
                rwbView.addSubview(playerCirView)
                rwbView.isHidden = false
            case "rcdm":
                let width = rcdmView.frame.width / 2
                playerCirView.frame = CGRect(x: width - (dimension / 2), y: 0, width: dimension, height: dimension)
                playerCirView.asCircle(color: colorBack)
                rcdmView.addSubview(playerCirView)
                rcdmView.isHidden = false
            case "cdm":
                let width = cdmView.frame.width / 2
                playerCirView.frame = CGRect(x: width - (dimension / 2), y: 0, width: dimension, height: dimension)
                playerCirView.asCircle(color: colorBack)
                cdmView.addSubview(playerCirView)
                cdmView.isHidden = false
            case "lcdm":
                let width = lcdmView.frame.width / 2
                playerCirView.frame = CGRect(x: width - (dimension / 2), y: 0, width: dimension, height: dimension)
                playerCirView.asCircle(color: colorBack)
                lcdmView.addSubview(playerCirView)
                lcdmView.isHidden = false
            case "lwb":
                let width = lwbView.frame.width / 2
                playerCirView.frame = CGRect(x: width - (dimension / 2), y: 0, width: dimension, height: dimension)
                playerCirView.asCircle(color: colorBack)
                lwbView.addSubview(playerCirView)
                lwbView.isHidden = false
            case "rm":
                let width = rmView.frame.width / 2
                playerCirView.frame = CGRect(x: width - (dimension / 2), y: 0, width: dimension, height: dimension)
                playerCirView.asCircle(color: colorBack)
                rmView.addSubview(playerCirView)
                rmView.isHidden = false
            case "rcm":
                let width = rcmView.frame.width / 2
                playerCirView.frame = CGRect(x: width - (dimension / 2), y: 0, width: dimension, height: dimension)
                playerCirView.asCircle(color: colorBack)
                rcmView.addSubview(playerCirView)
                rcmView.isHidden = false
            case "cm":
                let width = cmView.frame.width / 2
                playerCirView.frame = CGRect(x: width - (dimension / 2), y: 0, width: dimension, height: dimension)
                playerCirView.asCircle(color: colorBack)
                cmView.addSubview(playerCirView)
                cmView.isHidden = false
            case "lcm":
                let width = lcmView.frame.width / 2
                playerCirView.frame = CGRect(x: width - (dimension / 2), y: 0, width: dimension, height: dimension)
                playerCirView.asCircle(color: colorBack)
                lcmView.addSubview(playerCirView)
                lcmView.isHidden = false
            case "lm":
                let width = lmView.frame.width / 2
                playerCirView.frame = CGRect(x: width - (dimension / 2), y: 0, width: dimension, height: dimension)
                playerCirView.asCircle(color: colorBack)
                lmView.addSubview(playerCirView)
                lmView.isHidden = false
            case "rw":
                let width = rwView.frame.width / 2
                playerCirView.frame = CGRect(x: width - (dimension / 2), y: 0, width: dimension, height: dimension)
                playerCirView.asCircle(color: colorBack)
                rwView.addSubview(playerCirView)
                rwView.isHidden = false
            case "ram":
                let width = ramView.frame.width / 2
                playerCirView.frame = CGRect(x: width - (dimension / 2), y: 0, width: dimension, height: dimension)
                playerCirView.asCircle(color: colorBack)
                ramView.addSubview(playerCirView)
                ramView.isHidden = false
            case "cam":
                let width = camView.frame.width / 2
                playerCirView.frame = CGRect(x: width - (dimension / 2), y: 0, width: dimension, height: dimension)
                playerCirView.asCircle(color: colorBack)
                camView.addSubview(playerCirView)
                camView.isHidden = false
            case "lam":
                let width = lamView.frame.width / 2
                playerCirView.frame = CGRect(x: width - (dimension / 2), y: 0, width: dimension, height: dimension)
                playerCirView.asCircle(color: colorBack)
                lamView.addSubview(playerCirView)
                lamView.isHidden = false
            case "lw":
                let width = lwView.frame.width / 2
                playerCirView.frame = CGRect(x: width - (dimension / 2), y: 0, width: dimension, height: dimension)
                playerCirView.asCircle(color: colorBack)
                lwView.addSubview(playerCirView)
                lwView.isHidden = false
            case "str":
                let width = strView.frame.width / 2
                playerCirView.frame = CGRect(x: width - (dimension / 2), y: 0, width: dimension, height: dimension)
                playerCirView.asCircle(color: colorBack)
                strView.addSubview(playerCirView)
                strView.isHidden = false
            case "cf":
                let width = cfView.frame.width / 2
                playerCirView.frame = CGRect(x: width - (dimension / 2), y: 0, width: dimension, height: dimension)
                playerCirView.asCircle(color: colorBack)
                cfView.addSubview(playerCirView)
                cfView.isHidden = false
            case "stl":
                let width = stlView.frame.width / 2
                playerCirView.frame = CGRect(x: width - (dimension / 2), y: 0, width: dimension, height: dimension)
                playerCirView.asCircle(color: colorBack)
                stlView.addSubview(playerCirView)
                stlView.isHidden = false
            default:
                break
            }
        }
        centerAllPlayerStacks()
    }
    
    func removeAllPlayers() {
        for stack in playerStackView.arrangedSubviews {
            if let eachStack = stack as? UIStackView {
                for view in eachStack.arrangedSubviews {
                    view.subviews.forEach({ $0.removeFromSuperview() })
                }
            }
        }
    }
    
    func centerAllPlayerStacks() {
        for stack in playerStackView.arrangedSubviews {
            if let eachStack = stack as? UIStackView {
                eachStack.distribution = .fillEqually
            }
        }
    }
    
    func checkEntryWithStarters(name: String) {
        guard let teamSingle = self.team else { return }
        let starters = teamSingle.starters as NSMutableDictionary
        for (key, value) in starters {
            let player = value as! NSMutableDictionary
            if let first = player["fName"] as? String {
                if first.lowercased() == name {
                    player["enabled"] = true
                    playerTxtField.text = ""
                }
            }

            if let last = player["lName"] as? String {
                if last.lowercased() == name {
                    player["enabled"] = true
                    playerTxtField.text = ""
                }
            }
        }
        checkStarters()
    }
    
    // IB-Actions
    @IBAction func backBtnPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func textFieldValueChanged(_ sender: Any, forEvent event: UIEvent) {
        print("Holla")
        if let textField = sender as? UITextField {
            print(textField.text)
        }
    }
    @IBAction func textFieldEditing(_ sender: Any) {
        if let texting = sender as? UITextField {
            checkEntryWithStarters(name: texting.text!)
        }
    }
}
