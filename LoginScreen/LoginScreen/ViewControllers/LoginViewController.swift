//
//  LoginViewController.swift
//  LoginScreen
//
//  Created by Florian Marcu on 1/15/17.
//  Copyright © 2017 iOS App Templates. All rights reserved.
//

import FacebookCore
import FacebookLogin
import UIKit

class LoginViewController: UIViewController {

    // Add extra permissions you need
    // Remove permissions you don't need
    private let readPermissions: [ReadPermission] = [ .publicProfile, .email, .userFriends, .custom("user_posts") ]


    override func viewDidAppear(_ animated: Bool) {
        if let _ = AccessToken.current {
            didLoginWithFacebook()
            return;
        }
    }

    @IBAction func didTapLoginButton(_ sender: FacebookLoginButton) {
        let loginManager = LoginManager()
        loginManager.logIn(readPermissions, viewController: self, completion: didReceiveFacebookLoginResult)

    }

    private func didReceiveFacebookLoginResult(loginResult: LoginResult) {
        switch loginResult {
        case .success:
            didLoginWithFacebook()
        case .failed(_): break
        default: break
        }
    }

    private func didLoginWithFacebook() {
        if let accessToken = AccessToken.current {
            let facebookAPIManager = FacebookAPIManager(accessToken: accessToken)
            facebookAPIManager.requestFacebookUser(completion: { (facebookUser) in
                if let _ = facebookUser.email {
                    facebookAPIManager.requestWallPosts(completion: { (posts) in
                        print(posts)
                    })

                }
            })
        }
    }
}
