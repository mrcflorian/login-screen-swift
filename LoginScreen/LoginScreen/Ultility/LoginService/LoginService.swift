//
//  LoginService.swift
//  LoginScreen
//
//  Created by Duy Bui - iOS App Templates on 10/30/19.
//  Copyright © 2019 Duy Bui - iOS App Templates. All rights reserved.
//

import Foundation
protocol LoginService {
  func login(username: String, password: String, success: @escaping (User, String) -> Void, failure: @escaping (Error?) -> Void)
}
