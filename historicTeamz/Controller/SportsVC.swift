//
//  SportsVC.swift
//  historicTeamz
//
//  Created by Gurpal Bhoot on 1/20/19.
//  Copyright © 2019 Gurpal Bhoot. All rights reserved.
//

import UIKit

class SportsVC: UIViewController {
    
    // IBOutlets
    @IBOutlet weak var footballBtn: RoundedButton!
    @IBOutlet weak var basketballBtn: RoundedButton!
    @IBOutlet weak var hockeyBtn: RoundedButton!
    @IBOutlet weak var amFootballBtn: RoundedButton!
    
    // Variables
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    // Functions
    func setupView() {
        basketballBtn.isEnabled = false
        hockeyBtn.isEnabled = false
        amFootballBtn.isEnabled = false
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let segue_id = segue.identifier else { return }
        if segue_id == ID_SEGUE_TO_TEAM_LIST {
            if let destination = segue.destination as? TeamListVC {
                guard let title = (sender as! RoundedButton).currentTitle else { return }
                
                var newTitle = ""
                switch title {
                case "FOOTBALL":
                    newTitle = "Football Teams"
                    break
                case "BASKETBALL":
                    newTitle = "Basketball Teams"
                    break
                case "AMERICAN FOOTBALL":
                    newTitle = "American Football Teams"
                    break
                default:
                    newTitle = "Teams"
                }
                
                destination.titleText = newTitle
            }
        }
    }

    // IB-Actions
    @IBAction func sportsBtnPressed(_ sender: Any) {
        performSegue(withIdentifier: ID_SEGUE_TO_TEAM_LIST, sender: sender);
    }
}
