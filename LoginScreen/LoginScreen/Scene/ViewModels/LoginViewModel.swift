//
//  LoginViewModel.swift
//  LoginScreen
//
//  Created by Duy Bui - iOS App Templates on 10/29/19.
//  Copyright © 2019 Duy Bui - iOS App Templates. All rights reserved.
//

import Foundation

protocol LoginFunctionProtocol {
  
  func login(username: String?, password: String?, type: LoginType)
}

protocol LoginResultProtocol: class {
  func success(user: User?, type: LoginType)
  func error(error: Error, type: LoginType)
}

class LoginViewModel: LoginFunctionProtocol {
  
  var user: User?
  var token: String?
  weak var delegate: LoginResultProtocol?
  
  func login(username: String?, password: String?, type: LoginType) {
    /// It should have other validations here, if error, we will return error
    if let username = username, let password = password {
      user = User(username: username, password: password, token: token)
      delegate?.success(user: user, type: type)
    } else {
      delegate?.error(error: NSError(domain: "Value is nil", code: 1, userInfo:nil), type: type)
    }
  }
}
