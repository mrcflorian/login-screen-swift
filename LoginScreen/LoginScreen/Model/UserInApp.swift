//
//  UserInApp.swift
//  LoginScreen
//
//  Created by Duy Bui - iOS App Templates on 10/29/19.
//  Copyright © 2019 Duy Bui - iOS App Templates. All rights reserved.
//

import Foundation
// model 
enum LoginType: String {
  case normal = "Sign In normally"
  case facebook = "Facebook"
  case apple = "Apple"
  case google = "Google"
  
  var name: String {
    return self.rawValue
  }
}

struct User {
  var username: String?
  var password: String?
  var token: String?
  
  init(username: String?, password: String?, token: String? = nil) {
    self.username = username
    self.password = password
    self.token = token
  }
}
