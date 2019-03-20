//
//  GameCenterHelper.swift
//  historicTeamz
//
//  Created by Gurpal Bhoot on 3/19/19.
//  Copyright © 2019 Gurpal Bhoot. All rights reserved.
//

import GameKit

final class GameCenterHelper: NSObject {
    
    // Singleton
    static let helper = GameCenterHelper()
    
    // Variables
    var viewController: UIViewController?
    
    override init() {
        super.init()
        
        GKLocalPlayer.local.authenticateHandler = { gcAuthVC, error in
            NotificationCenter.default.post(name: .authenticationChanged, object: GKLocalPlayer.local.isAuthenticated)
            
            if GKLocalPlayer.local.isAuthenticated {
                print("Authenticated to Game Center")
            } else if let vc = gcAuthVC {
                self.viewController?.present(vc, animated: true, completion: nil)
            } else {
                print("Error authenticating to Game Center: " +
                    "\(error?.localizedDescription ?? "none")")
            }
        }
    }
}

extension Notification.Name {
    static let presentGame = Notification.Name(rawValue: "presentGame")
    static let authenticationChanged = Notification.Name(rawValue: "authenticationChanged")
}
