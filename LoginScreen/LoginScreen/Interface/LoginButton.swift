//
//  LoginButton.swift
//  LoginScreen
//
//  Created by Florian Marcu on 1/15/17.
//  Copyright © 2017 iOS App Templates. All rights reserved.
//

import UIKit

let kLoginButtonBackgroundColor = UIColor(displayP3Red: 31/255, green: 75/255, blue: 164/255, alpha: 1)
let kLoginButtonTintColor = UIColor.white
let kLoginButtonCornerRadius: CGFloat = 13.0

class LoginButton: UIButton {

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.configureUI()
    }

    private func configureUI() {
        self.backgroundColor = kLoginButtonBackgroundColor
        self.layer.cornerRadius = kLoginButtonCornerRadius
        self.tintColor = kLoginButtonTintColor
        self.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 14)
    }

}
