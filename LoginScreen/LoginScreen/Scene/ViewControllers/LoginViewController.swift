//
//  LoginViewController.swift
//  LoginScreen
//
//  Created by Duy Bui - iOS App Templates on 10/29/19.
//  Copyright © 2019 Duy Bui - iOS App Templates. All rights reserved.
//

import UIKit
import AuthenticationServices
import FBSDKCoreKit
import FBSDKLoginKit
import GoogleSignIn

class LoginViewController: UIViewController {
  
  
  @IBOutlet weak var userNameTextField: CustomTextField!
  @IBOutlet weak var passwordTextField: CustomTextField!
  @IBOutlet weak var signInButton: UIButton!
  @IBOutlet weak var facebookButton: UIButton!
  @IBOutlet weak var googleButton: UIButton!
  @IBOutlet weak var appleButton: UIButton!
  let viewModel = LoginViewModel()
  
  override func viewDidLoad() {
    
    super.viewDidLoad()
    
  }
  
  override func viewWillAppear(_ animated: Bool) {
    
    super.viewWillAppear(animated)
    
    initializeData()
  }
  
  private func initializeData() {
    /// Placeholder text
    userNameTextField.placeholderText = "Username"
    passwordTextField.placeholderText = "Password"
    
    /// Make the buttons more catchy
    signInButton.corner()
    [facebookButton, googleButton, appleButton].forEach { $0?.corner(radius: 10) }
    
    /// Delegate the protocol
    viewModel.delegate = self
  }
  
  // MARK: - IBAction
  @IBAction func didTapSignInButton(_ sender: Any) {
    viewModel.login(username: userNameTextField.text, password: passwordTextField.text, type: .normal)
  }
  
  @IBAction func didTapFacebookButton(_ sender: Any) {
    handleFacebookAuthentication()
  }
  
  @IBAction func didTapGoogleButton(_ sender: Any) {
    handleGoogleAuthentication()
  }
  
  @IBAction func didTapAppleButton(_ sender: Any) {
    handleAppleAuthentication()
  }
}

// MARK: - Login with Apple
extension LoginViewController: ASAuthorizationControllerDelegate, ASAuthorizationControllerPresentationContextProviding {
  
  /// Our custom functions
  private func handleAppleAuthentication() {
    let appleIDProvider = ASAuthorizationAppleIDProvider()
    let request = appleIDProvider.createRequest()
    request.requestedScopes = [.fullName, .email]
    
    let authorizationController = ASAuthorizationController(authorizationRequests: [request])
    authorizationController.presentationContextProvider = self
    authorizationController.delegate = self
    authorizationController.performRequests()
  }
  
  /// Required functions from protocols
  func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
    guard let appleCredential = authorization.credential as? ASAuthorizationAppleIDCredential else { return }
    viewModel.login(username: appleCredential.email, password: nil, type: .apple)
    viewModel.token = String(describing: appleCredential.identityToken.hashValue)
  }
  
  func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
    return self.view.window!
  }
}

// MARK: - Login with facebook
extension LoginViewController {
  
  /// Our custom functions
  private func handleFacebookAuthentication() {
    let loginManager = LoginManager()
    loginManager.logIn(permissions: ["email"], from: self) { (result, error) in
        if error != nil {
          self.showPopup(isSuccess: false, type: .facebook)
            return
        }
        guard let token = AccessToken.current else {
            print("Failed to get access token")
            self.showPopup(isSuccess: false, type: .facebook)
            return
        }
      self.viewModel.token = token.appID
      
      GraphRequest(graphPath: "me", parameters: ["fields": "email"]).start(completionHandler: { (connection, result, error) -> Void in
          if (error == nil), let result = result as? [String: Any], let email = result["email"] as? String {
            self.viewModel.login(username: email, password: "", type: .facebook)
          }
      })
    }
  }
}

// MARK: - Login with google
extension LoginViewController: GIDSignInDelegate {
  
  /// Our custom functions
  private func handleGoogleAuthentication() {
    GIDSignIn.sharedInstance()?.clientID = "350995020018-79bumcion7icu71tvev6qie3nos6bul3.apps.googleusercontent.com"
    GIDSignIn.sharedInstance()?.presentingViewController = self
    GIDSignIn.sharedInstance()?.delegate = self
    GIDSignIn.sharedInstance()?.signIn()
  }
  
  /// Required functions from protocols
  func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
    if error != nil {
      showPopup(isSuccess: false, type: .google)
    } else {
      viewModel.login(username: user.profile.name, password: "", type: .google)
    }
  }
}

// MARK: - Show result
extension LoginViewController: LoginResultProtocol {
  
  func showPopup(isSuccess: Bool, user: User? = nil, type: LoginType) {
    let successMessage = "Congratulation! \(user?.username ?? ""). You logged in successully with \(type.name). "
    let errorMessage = "Something went wrong. Please try again"
    let alert = UIAlertController(title: isSuccess ? "Success": "Error", message: isSuccess ? successMessage: errorMessage, preferredStyle: UIAlertController.Style.alert)
    alert.addAction(UIAlertAction(title: "Done", style: UIAlertAction.Style.default, handler: nil))
    self.present(alert, animated: true, completion: nil)
  }
  
  func success(user: User?, type: LoginType) {
    showPopup(isSuccess: true, user: viewModel.user, type: type)
  }
  
  func error(error: Error, type: LoginType) {
    showPopup(isSuccess: false, type: type)
  }
}

