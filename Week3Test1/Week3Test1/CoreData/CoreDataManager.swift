//
//  CoreDataManager.swift
//  Week3Test1
//
//  Created by MCS on 7/25/19.
//  Copyright © 2019 MCS. All rights reserved.
//

import Foundation
import CoreData

final class CoreDataManager {
  
  lazy var persistentContainer: NSPersistentContainer = {
    let container = NSPersistentContainer(name: "FavoriteModel")
    container.loadPersistentStores { description, error in }
    return container
  }()
  
  var context: NSManagedObjectContext {
    return persistentContainer.viewContext
  }
  
  @discardableResult
    func createNewFavorite(image: Image) -> Favorite? {
      guard let description = NSEntityDescription.entity(forEntityName: "Favorite", in: context) else { return nil }
      let favorite = Favorite(entity: description, insertInto: context)
      favorite.user = image.user
      favorite.previewURL = image.previewURL
      favorite.webformatURL = image.webformatURL
      favorite.likes = image.likes
      favorite.views = image.views
      favorite.comments = image.comments
      return favorite
    }
  
  func delete(image: Image) {
    guard let favorite = getFavorite(image: image) else { return }
    context.delete(favorite)
  }
  
  func getFavorites() -> [Image] {
    let request: NSFetchRequest<Favorite> = Favorite.fetchRequest()
    do {
      let favorites = try context.fetch(request)
      var images: [Image] = []
      var image = Image()
      
      for favorite in favorites {
        image.user = favorite.user
        image.previewURL = favorite.previewURL
        image.webformatURL = favorite.webformatURL
        image.views = favorite.views
        image.likes = favorite.likes
        image.comments = favorite.comments

        images.append(image)
      }
      return images
    } catch {
      return []
    }
  }
  
  func getFavorite(image: Image) -> Favorite? {
    let request: NSFetchRequest<Favorite> = Favorite.fetchRequest()
    request.predicate = NSPredicate(format: "previewURL=%@", image.previewURL)
    
    let favorite = try? context.fetch(request)
    
    return favorite?.first
  }
  
  func save() {
    try? context.save()
  }
}
