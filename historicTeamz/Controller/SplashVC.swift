//
//  ViewController.swift
//  historicTeamz
//
//  Created by Gurpal Bhoot on 1/18/19.
//  Copyright © 2019 Gurpal Bhoot. All rights reserved.
//

import UIKit

class SplashVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        GameCenterHelper.helper.viewController = self
    }
    
    @objc private func authenticationChanged(_ notification: Notification) {
        print("User is authenticated: ", notification.object as? Bool ?? false)
    }
}

