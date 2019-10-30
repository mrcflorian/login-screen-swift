//
//  UserInApp.swift
//  LoginScreen
//
//  Created by Duy Bui - iOS App Templates on 10/29/19.
//  Copyright © 2019 Duy Bui - iOS App Templates. All rights reserved.
//

import Foundation
enum LoginType: String {
  case normal = "Sign In normally"
  case facebook = "Facebook"
  case apple = "Apple"
  case google = "Google"
  
  var name: String {
    return self.rawValue
  }
}

protocol UserProtocol {
  var username: String? { get set }
  var password: String? { get set }
}

struct User: UserProtocol {
  var username: String?
  var password: String?
  
  init(username: String?, password: String?) {
    self.username = username
    self.password = password
  }
}

struct GoogleUser: UserProtocol {
  var username: String?
  var password: String?
  var googleToken: String?
  
  init(username: String?, password: String?, googleToken: String?) {
    self.username = username
    self.password = password
    self.googleToken = googleToken
  }
}

struct FacebookUser: UserProtocol {
  var username: String?
  var password: String?
  var facebookToken: String?
  
  init(username: String?, password: String?, facebookToken: String?) {
    self.username = username
    self.password = password
    self.facebookToken = facebookToken
  }
}

struct AppleUser: UserProtocol {
  var username: String?
  var password: String?
  var appleToken: String?
  
  init(username: String?, password: String?, appleToken: String?) {
    self.username = username
    self.password = password
    self.appleToken = appleToken
  }
}
