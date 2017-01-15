//
//  FacebookLoginButton.swift
//  LoginScreen
//
//  Created by Florian Marcu on 1/15/17.
//  Copyright © 2017 iOS App Templates. All rights reserved.
//

import UIKit

let kFacebookLoginButtonBackgroundColor = UIColor(colorLiteralRed: 59/255, green: 89/255, blue: 153/255, alpha: 1)
let kFacebookLoginButtonTintColor = UIColor.white
let kFacebookLoginButtonCornerRadius: CGFloat = 15.0

class FacebookLoginButton: UIButton {

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.configureUI()
    }

    private func configureUI() {
        self.backgroundColor = kLoginButtonBackgroundColor
        self.layer.cornerRadius = kLoginButtonCornerRadius
        self.tintColor = kLoginButtonTintColor
        self.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 12)
    }

}
