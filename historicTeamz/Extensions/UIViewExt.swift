//
//  UIViewExt.swift
//  historicTeamz
//
//  Created by Gurpal Bhoot on 1/23/19.
//  Copyright © 2019 Gurpal Bhoot. All rights reserved.
//

import UIKit

extension UIView {
    func addBackground(imageName: String) {
        let width = self.bounds.size.width
        let height = self.bounds.size.height
        print(width, height)
        
        let imageViewBackground = UIImageView(frame: self.bounds)
        imageViewBackground.image = UIImage(named: imageName)
        imageViewBackground.contentMode = .scaleAspectFill
        imageViewBackground.clipsToBounds = true
        
        self.addSubview(imageViewBackground)
//        self.sendSubviewToBack(imageViewBackground)
    }
}
