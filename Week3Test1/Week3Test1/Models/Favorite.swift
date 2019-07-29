//
//  Favorite.swift
//  Week3Test1
//
//  Created by MCS on 7/26/19.
//  Copyright © 2019 MCS. All rights reserved.
//

import Foundation
import CoreData

@objc(Favorite)
public class Favorite: NSManagedObject {
  
  @nonobjc public class func fetchRequest() -> NSFetchRequest<Favorite> {
    return NSFetchRequest<Favorite>(entityName: "Favorite")
  }
  
  @NSManaged public var user: String
  @NSManaged public var previewURL: String
  @NSManaged public var webformatURL: String
  @NSManaged public var likes: Int
  @NSManaged public var views: Int
  @NSManaged public var comments: Int
  
}
