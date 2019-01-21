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
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    

    // IB-Actions
    @IBAction func sportsBtnPressed(_ sender: Any) {
        guard let title = (sender as! RoundedButton).currentTitle else { return }
        print(title)
    }
}
