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
        let imageViewBackground = UIImageView(frame: self.bounds)
        imageViewBackground.image = UIImage(named: imageName)

        imageViewBackground.contentMode = .scaleToFill
//        imageViewBackground.clipsToBounds = true
        
        self.addSubview(imageViewBackground)
        self.sendSubviewToBack(imageViewBackground)
    }
    
    // Bind view frame to keyboard
    func bindToKeyboard() {
        NotificationCenter.default.addObserver(self, selector: #selector(UIView.keyboardWillChange(_:)), name: UIView.keyboardWillChangeFrameNotification, object: nil)
    }
    
    @objc func keyboardWillChange(_ notification: Notification) {
        let duration = notification.userInfo![UIResponder.keyboardAnimationDurationUserInfoKey] as! Double
        let curve = notification.userInfo![UIResponder.keyboardAnimationCurveUserInfoKey] as! UInt
        let curFrame = (notification.userInfo![UIResponder.keyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
        let targetFrame = (notification.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        let deltaY = targetFrame.origin.y - curFrame.origin.y
        
        UIView.animate(withDuration: duration, delay: 0.0, options: UIView.AnimationOptions(rawValue: curve), animations: {
            self.frame.origin.y += (deltaY / 2)
        }) { (success) in
            self.layoutIfNeeded()
        }
    }
}
