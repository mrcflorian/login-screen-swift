//
//  AppleLoginService.swift
//  LoginScreen
//
//  Created by Duy Bui - iOS App Templates on 10/30/19.
//  Copyright © 2019 Duy Bui - iOS App Templates. All rights reserved.
//

import UIKit
import AuthenticationServices

class AppleLogin {
  
  func login(email: String, password: String, completion: @escaping (AppleUser?, Error?) -> Void) {
    
    
    let token = "special-token-value"
    let user = AppleUser(username: email, password: password, appleToken: token)
    completion(user, nil)
  }
}

class AppleLoginAdapter: LoginService {
  // 2
  private var appleLogin = AppleLogin()
  // 3
  public func login(username: String,
                    password: String,
                    success: @escaping (User, String) -> Void,
                    failure: @escaping (Error?) -> Void) {
    
//    appleLogin.login(email: email, password: password) {
//      (googleUser, error) in
//      guard let googleUser = googleUser else {
//        failure(error)
//        return
//      }
//      // 4
//      let user = User(email: googleUser.email,
//                      password: googleUser.password)
//      success(user, token)
//    }
  }
}
