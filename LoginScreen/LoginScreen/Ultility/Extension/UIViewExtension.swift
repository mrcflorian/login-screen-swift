//
//  UIViewExtension.swift
//  LoginScreen
//
//  Created by Duy Bui - iOS App Templates on 10/29/19.
//  Copyright © 2019 Duy Bui - iOS App Templates. All rights reserved.
//

import UIKit

extension UIView {
  func corner(radius: CGFloat = 25) {
    self.layer.cornerRadius = radius
    self.layer.masksToBounds = true
  }
}
