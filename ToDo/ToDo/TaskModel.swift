//
//  TaskViewModel.swift
//  ToDo
//
//  Created by MCS on 7/24/19.
//  Copyright © 2019 MCS. All rights reserved.
//

import Foundation
import CoreData

@objc(Task)
public class Task: NSManagedObject {
  
  @nonobjc public class func fetchRequest() -> NSFetchRequest<Task> {
    return NSFetchRequest<Task>(entityName: "Task")
  }
  
  @NSManaged public var taskDescription: String?
  
}
