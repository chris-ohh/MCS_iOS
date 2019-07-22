//
//  ViewController.swift
//  ToDo
//
//  Created by MCS on 7/12/19.
//  Copyright © 2019 MCS. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
  @IBOutlet weak var toDo: UITableView!

  let manager = CoreDataManager()
    
  override func viewDidLoad() {
    super.viewDidLoad()
    toDo.dataSource = self
    toDo.delegate = self
    toDo.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    
    manager.createNewTasks(with: "Wake Up")
    manager.createNewTasks(with: "Eat Breakfast")
    manager.createNewTasks(with: "Take the MARTA")
    manager.createNewTasks(with: "Walk to work")
    manager.createNewTasks(with: "Take candy from the jar")
  }
}

extension ViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return manager.getNumberOfTasks()
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
      
    cell.textLabel?.text = manager.getTask(at: indexPath.row)?.taskDescription
    return cell
  }
}

extension ViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    let editViewController = storyboard.instantiateViewController(withIdentifier: "EditViewController") as! EditViewController
      
    editViewController.stringToEdit = manager.getTask(at: indexPath.row)?.taskDescription
    editViewController.delegate = self
        
    navigationController?.pushViewController(editViewController, animated: true)
  }
}

extension ViewController: EditViewControllerDelegate {
  func update(to newValue: String) {
    guard let updatedIndex = toDo.indexPathForSelectedRow else { return }
      
    manager.update(at: updatedIndex.row, with: newValue)
      
    toDo.reloadRows(at: [updatedIndex], with: .fade)
  }
    
  func delete() {
    guard let deletedIndex = toDo.indexPathForSelectedRow else { return }
      
    manager.delete(at: deletedIndex.row)
      
    toDo.deleteRows(at: [deletedIndex], with: .fade)
  }
}
