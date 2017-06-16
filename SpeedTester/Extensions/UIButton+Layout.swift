//
//  UIButton+Layout.swift
//  SpeedTester
//
//  Created by Ranosys on 16/06/17.
//  Copyright © 2017 Jogendar. All rights reserved.
//

import Foundation
import UIKit
extension UIButton {
    
    func setLayout() {
        self.layer.cornerRadius = self.frame.size.height/2
    }
    func setBackground() {
        self.backgroundColor = self.isSelected ? UIColor.red: UIColor(red: 33.0/255, green: 126.0/255, blue: 169.0/255, alpha: 1.0)
    }
}
