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
        
        self.addSubview(imageViewBackground)
        self.sendSubviewToBack(imageViewBackground)
    }
    
    func asCircle(color: UIColor) {
        self.layer.cornerRadius = self.frame.width / 2
        self.layer.masksToBounds = true
        self.backgroundColor = color
    }
    
    // Bind view frame to keyboard
    func bindToKeyboard() {
//        NotificationCenter.default.addObserver(self, selector: #selector(UIView.keyboardWillChange(_:)), name: UIView.keyboardWillChangeFrameNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(UIView.keyboardWillShow(notification:)), name: UIView.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(UIView.keyboardWillHide(notification:)), name: UIView.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(notification: Notification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.frame.origin.y == 402 {
                UIView.animate(withDuration: 0.4, animations: {
                    self.frame.origin.y -= keyboardSize.height
                }) { (success) in
                    self.layoutIfNeeded()
                }
            }
        }
    }
    
    @objc func keyboardWillHide(notification: Notification) {
        print("What's the big deal")
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.frame.origin.y != 0 {
                UIView.animate(withDuration: 0.4, animations: {
                self.frame.origin.y += keyboardSize.height
                }) { (success) in
                    self.layoutIfNeeded()
                }
            }
        }
    }
    
    @objc func keyboardWillChange(_ notification: Notification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            print(self.frame.origin.y)
            if self.frame.origin.y == 402 {
                self.frame.origin.y -= keyboardSize.height
            } else if self.frame.origin.y == (402 - keyboardSize.height) {
                self.frame.origin.y = 402
            }
        }
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
