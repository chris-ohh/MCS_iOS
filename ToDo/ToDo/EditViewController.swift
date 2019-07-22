//
//  EditViewController.swift
//  ToDo
//
//  Created by MCS on 7/12/19.
//  Copyright © 2019 MCS. All rights reserved.
//

import UIKit

protocol EditViewControllerDelegate {
  
  func update(to newValue: String)
    
  func delete()
}

class EditViewController: UIViewController {
    
  @IBOutlet weak var editTextfield: UITextField!
  
  var stringToEdit: String?
  var delegate: EditViewControllerDelegate?
    
  override func viewDidLoad() {
    super.viewDidLoad()
    editTextfield.text = stringToEdit
  }
    
  @IBAction func submit(_ sender: UIButton) {
      
    if sender.tag == 0 {
      // Edit
      if let updateString = editTextfield.text {
        delegate?.update(to: updateString)
      } else if sender.tag == 1 {
          // Completed
          delegate?.delete()
      }
      navigationController?.popViewController(animated: true)
    }
}
