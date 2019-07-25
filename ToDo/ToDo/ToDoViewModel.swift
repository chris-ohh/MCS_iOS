//
//  TaskViewModel.swift
//  ToDo
//
//  Created by MCS on 7/24/19.
//  Copyright © 2019 MCS. All rights reserved.
//

import Foundation
import CoreData

public class ToDoViewModel {
  
  let manager = CoreDataManager()
  
  var tasks: [Task] = []
  
  var taskDescription: String?
  
  func createNewTasks(with taskDescription: String) -> Task? {
    guard let task = manager.createNewTasks(with: taskDescription) else { return nil }
    task.taskDescription = taskDescription
    tasks.append(task)
    return task
  }
  
  func update(at index: Int, with newTaskDescription: String) -> Task {
    tasks[index].taskDescription = newTaskDescription
    
    return tasks[index]
  }
  
  func delete(at index: Int) -> [Task]? {
    guard let task = getTask(at: index) else { return nil }
    manager.delete(task: task)
    tasks.remove(at: index)
    return tasks
  }
  
  func getAllTasks(named taskDescription: String) -> [Task] {
    return manager.getAllTasks(named: taskDescription)
  }
  
  func getAllTasks() -> [Task] {
    return tasks
  }
  
  func getTask(at index: Int) -> Task? {
    guard index >= 0 && index < tasks.count else { return nil }
    return tasks[index]
  }
  
  func getNumberOfTasks() -> Int {
    return getAllTasks().count
  }
  
  func save() {
    manager.save()
  }

}
