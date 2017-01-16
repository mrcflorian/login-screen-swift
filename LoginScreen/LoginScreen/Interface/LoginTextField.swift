//
//  LoginTextField.swift
//  LoginScreen
//
//  Created by Florian Marcu on 1/16/17.
//  Copyright © 2017 iOS App Templates. All rights reserved.
//

import UIKit
import QuartzCore

class LoginTextField: UITextField {

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.configureUI()
    }

    private func configureUI() {
        self.layer.borderColor = UIColor.gray.cgColor
        self.layer.borderWidth = 0.5
        self.layer.cornerRadius = 4.0
    }
}
