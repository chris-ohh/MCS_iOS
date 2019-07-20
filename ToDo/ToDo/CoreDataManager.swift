//
//  CoreDataManager.swift
//  ToDo
//
//  Created by MCS on 7/19/19.
//  Copyright © 2019 MCS. All rights reserved.
//

import Foundation
import CoreData

final class CoreDataManager {
  
  private var tasks: [Task] = []
  
  lazy var persistentContainer: NSPersistentContainer = {
    let container = NSPersistentContainer(name: "TaskModel")
    container.loadPersistentStores { description, error in }
    return container
  }()
  
  var context: NSManagedObjectContext {
    return persistentContainer.viewContext
  }
  
  @discardableResult
  func createNewTasks(with taskDescription: String) -> Task? {
    guard let description = NSEntityDescription.entity(forEntityName: "Task", in: context) else { return nil }
    let task = Task(entity: description, insertInto: context)
    task.taskDescription = taskDescription
    tasks.append(task)
    return task
  }
  
  func update(at index: Int, with newTaskDescription: String) -> Task {
    tasks[index].taskDescription = newTaskDescription
    
    print(getAllTasks())
    
    return tasks[index]
  }
  
  func delete(at index: Int) {
    context.delete(getTask(at: index)!)
    tasks.remove(at: index)
  }
  
  func getAllTasks(named taskDescription: String) -> [Task] {
    let request: NSFetchRequest<Task> = Task.fetchRequest()
    request.predicate = NSPredicate(format: "taskDescription=%@", taskDescription)
    do {
      let tasks = try context.fetch(request)
      return tasks
    } catch {
      return []
    }
  }
  
  func getAllTasks() -> [Task] {
    let request: NSFetchRequest<Task> = Task.fetchRequest()
    do {
      let tasks = try context.fetch(request)
      return tasks
    } catch {
      return []
    }
  }
  
  func getTask(at index: Int) -> Task? {
    guard index >= 0 && index < tasks.count else { return nil }
    return tasks[index]
  }
  
  func getNumberOfTasks() -> Int {
    return getAllTasks().count
  }
  
  func save() {
    guard context.hasChanges else { return }
    try? context.save()
  }
}
