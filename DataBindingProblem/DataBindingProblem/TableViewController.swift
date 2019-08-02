//
//  TableViewController.swift
//  DataBindingProblem
//
//  Created by MCS on 8/2/19.
//  Copyright © 2019 MCS. All rights reserved.
//

import UIKit


class TableViewController: UIViewController {

  @IBOutlet weak var tableView: UITableView!
  
  var selectedIndex: Int = 0
  
  
  struct BoundString {
    var string: String = "" {
      didSet(newString) {
        string = newString
        //dataSource[selectedIndex].string =
      }
    }
    
    init(string: String) {
      self.string = string
    }
  }
  
  var dataSource: [BoundString] = [BoundString(string: "this"),
                                   BoundString(string: "is"),
                                   BoundString(string: "so"),
                                   BoundString(string: "hard"),
                                   BoundString(string: "!")]
  
  
  override func viewDidLoad() {
        super.viewDidLoad()

    tableView.dataSource = self
    tableView.delegate = self
    tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
    }

    // MARK: - Table view data source

}

extension TableViewController: UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return dataSource.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
    
    cell.textLabel?.text = dataSource[indexPath.row].string
    return cell
  }
}

extension TableViewController: UITableViewDelegate {
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    selectedIndex = indexPath.row
    dataSource[indexPath.row].string = "you clicked this"
    print(indexPath)
  }
}
