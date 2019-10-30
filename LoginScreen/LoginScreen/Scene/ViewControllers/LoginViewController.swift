//
//  LoginViewController.swift
//  LoginScreen
//
//  Created by Duy Bui - iOS App Templates on 10/29/19.
//  Copyright © 2019 Duy Bui - iOS App Templates. All rights reserved.
//

import UIKit
import AuthenticationServices

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
    [facebookButton, googleButton, appleButton].forEach { $0?.corner(radius: 5) }
    
    /// Delegate the protocol
    viewModel.delegate = self
  }
  
  // MARK: - IBAction
  
  @IBAction func didTapSignInButton(_ sender: Any) {
    
    viewModel.login(username: userNameTextField.text, password: passwordTextField.text, type: .normal)
  }
  
  @IBAction func didTapFacebookButton(_ sender: Any) {
    viewModel.login(username: userNameTextField.text, password: passwordTextField.text, type: .normal)
  }
  
  @IBAction func didTapGoogleButton(_ sender: Any) {
    viewModel.login(username: userNameTextField.text, password: passwordTextField.text, type: .normal)
  }
  
  @IBAction func didTapAppleButton(_ sender: Any) {
    checkAppleRequest()
  }
}

/// MARK: - Login with Apple
extension LoginViewController: ASAuthorizationControllerDelegate, ASAuthorizationControllerPresentationContextProviding {
  
    private func checkAppleRequest() {
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.fullName, .email]
        
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.presentationContextProvider = self
        authorizationController.delegate = self
        authorizationController.performRequests()
    }
  
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        guard let appleCredential = authorization.credential as? ASAuthorizationAppleIDCredential else { return }
      
      viewModel.login(username: appleCredential.email, password: String(describing: appleCredential.identityToken.hashValue), type: .apple)
    }
    
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return self.view.window!
    }
}

extension LoginViewController: LoginResultProtocol {
  
  private func showPopup(isSuccess: Bool, user: User? = nil, type: LoginType) {
    let successMessage = "Congratulation! \(user?.username ?? ""). You logged in successully with \(type.name). "
    let errorMessage = "Something went wrong. Please try again"
    let alert = UIAlertController(title: isSuccess ? "Success": "Error", message: isSuccess ? successMessage: errorMessage, preferredStyle: UIAlertController.Style.alert)
    alert.addAction(UIAlertAction(title: "Done", style: UIAlertAction.Style.default, handler: nil))
    self.present(alert, animated: true, completion: nil)
  }
  
  func success(user: UserProtocol?, type: LoginType) {
    showPopup(isSuccess: true, user: viewModel.user, type: type)
  }
  
  func error(error: Error, type: LoginType) {
    showPopup(isSuccess: false, type: type)
  }
}
 
