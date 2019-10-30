//
//  CustomTextField.swift
//  LoginScreen
//
//  Created by Duy Bui - iOS App Templates on 10/29/19.
//  Copyright © 2019 Duy Bui - iOS App Templates. All rights reserved.
//

import UIKit

class CustomTextField: UIView {
  
  @IBOutlet weak var textField: UITextField!
  private let placeholderColor = UIColor(red: 122.5/255, green: 121.5/255, blue: 120.25/255, alpha: 0.7)
  
  var placeholderText: String = "" {
    didSet {
      textField.attributedPlaceholder = NSAttributedString(string: placeholderText,
                                                           attributes: [NSAttributedString.Key.foregroundColor: placeholderColor])
    }
  }
  
  var text: String? {
    return textField.text
  }
  // MARK: - Initializer
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    self.loadFromNib()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    
    self.loadFromNib()
  }
  
  func loadFromNib() {
    if let contentView = Bundle.main.loadNibNamed("CustomTextField", owner: self, options: nil)?.first as? UIView {
      contentView.frame = bounds
      addSubview(contentView)
    }
  }
}
