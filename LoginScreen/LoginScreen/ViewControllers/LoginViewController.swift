//
//  LoginViewController.swift
//  LoginScreen
//
//  Created by Florian Marcu on 1/15/17.
//  Copyright © 2017 iOS App Templates. All rights reserved.
//

import FacebookCore
import FacebookLogin
import TwitterKit
import UIKit

class LoginViewController: UIViewController {


    @IBOutlet var usernameTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!

    // Facebook login permissions
    // Add extra permissions you need
    // Remove permissions you don't need
    private let readPermissions: [ReadPermission] = [ .publicProfile, .email, .userFriends, .custom("user_posts") ]

    @IBAction func didTapLoginButton(_ sender: LoginButton) {
        // Regular login attempt. Add the code to handle the login by email and password.
        guard let email = usernameTextField.text, let pass = passwordTextField.text else {
            // It should never get here
            return
        }
        didLogin(method: "email and password", info: "Email: \(email) \n Password: \(pass)")
    }

    @IBAction func didTapFacebookLoginButton(_ sender: FacebookLoginButton) {
        // Facebook login attempt
        let loginManager = LoginManager()
        loginManager.logIn(readPermissions: readPermissions, viewController: self, completion: didReceiveFacebookLoginResult)
    }

    @IBAction func didTapTwitterLoginButton(_ sender: TwitterLoginButton) {
        // Twitter login attempt
        Twitter.sharedInstance().logIn(completion: { session, error in
            if let session = session {
                // Successful log in with Twitter
                print("signed in as \(session.userName)");
                let info = "Username: \(session.userName) \n User ID: \(session.userID)"
                self.didLogin(method: "Twitter", info: info)
            } else {
                print("error: \(error?.localizedDescription)");
            }
        })
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        usernameTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
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
        // Successful log in with Facebook
        if let accessToken = AccessToken.current {
            let facebookAPIManager = FacebookAPIManager(accessToken: accessToken)
            facebookAPIManager.requestFacebookUser(completion: { (facebookUser) in
                if let _ = facebookUser.email {
                    let info = "First name: \(facebookUser.firstName!) \n Last name: \(facebookUser.lastName!) \n Email: \(facebookUser.email!)"
                    self.didLogin(method: "Facebook", info: info)
                }
            })
        }
    }

    private func didLogin(method: String, info: String) {
        let message = "Successfully logged in with \(method). " + info
        let alert = UIAlertController(title: "Success", message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Done", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
