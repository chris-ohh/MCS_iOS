//
//  Task+CoreDataProperties.swift
//  ToDo
//
//  Created by MCS on 7/19/19.
//  Copyright © 2019 MCS. All rights reserved.
//


import Foundation
import CoreData


extension Task {
  
  @nonobjc public class func fetchRequest() -> NSFetchRequest<Task> {
    return NSFetchRequest<Task>(entityName: "Task")
  }
  
  @NSManaged public var taskDescription: String?
  
}
