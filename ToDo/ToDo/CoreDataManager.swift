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
  
  lazy var persistentContainer: NSPersistentContainer = {
    let container = NSPersistentContainer(name: "TaskModel")
    container.loadPersistentStores { description, error in }
    return container
  }()
  
  var context: NSManagedObjectContext {
    return persistentContainer.viewContext
  }
  
  @discardableResult
  func createNewTasks() -> Task? {
    guard let description = NSEntityDescription.entity(forEntityName: "Task", in: context) else { return nil }
    let task = Task(entity: description, insertInto: context)
    return task
  }
  
  func delete(task: Task) {
    context.delete(task)
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
  
  func save() {
    guard context.hasChanges else { return }
    try? context.save()
  }
}
