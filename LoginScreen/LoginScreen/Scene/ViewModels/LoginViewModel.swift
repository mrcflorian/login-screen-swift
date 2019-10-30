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
  func success(user: UserProtocol?, type: LoginType)
  func error(error: Error, type: LoginType)
}

class LoginViewModel: LoginFunctionProtocol {
  
  var user: User?
  weak var delegate: LoginResultProtocol?
  func login(username: String?, password: String?, type: LoginType) {
      /// It should have other validations here, if error, we will return error
    if let username = username, let password = password {
      switch type {
      case .normal:
        user = User(username: username, password: password)
        delegate?.success(user: user, type: type)
      
      case .google:
        let user = User(username: username, password: password)
      
      case .facebook:
        let user = User(username: username, password: password)
      
      case .apple:
        let user = User(username: username, password: password)
      }
    } else {
      
      delegate?.error(error: NSError(domain: "Value is nil", code: 1, userInfo:nil), type: type)
    }
  }
  
  
}
