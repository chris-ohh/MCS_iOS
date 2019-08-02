//
//  ViewController.swift
//  DataBindingProblem
//
//  Created by MCS on 8/2/19.
//  Copyright © 2019 MCS. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  @IBOutlet weak var textField: UITextField!
  
  var boundString: String = "" {
    didSet(newString) {
      textField.text = newString
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
    
    bind(subView: textField)
  }

  
  @IBAction func textChanged(_ sender: Any) {
    boundString = textField.text!
  }
  
  
  @IBAction func buttonTapped(_ sender: Any) {
    boundString = ""
  }
  
}



protocol UITextFieldDelegate {
  static var stringValue: String? { get }
}

struct TextFieldContainer {
  var textField: UITextField
  
  init(view: UIView) {
    self.textField = view as! UITextField
  }
  
  func setValue(value: String) {
    self.textField.text = value
    
  }
}

func bind<T: UIView> (subView: T) {
  //subView as UITextField
  let view = subView as! UITextField
  //view.text
  
}


