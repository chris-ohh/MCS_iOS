//
//  FavoriteViewModel.swift
//  Week3Test1
//
//  Created by MCS on 7/25/19.
//  Copyright © 2019 MCS. All rights reserved.
//

import Foundation

public class FavoriteViewModel {
  
  private let manager = CoreDataManager()
  private var images: [Image] = []
  
  func createNewFavorite(image: Image) -> Favorite? {
    return manager.createNewFavorite(image: image)
  }
  
  func getFavorites() -> [Image] {
    return manager.getFavorites()
  }
  
  func getFavorite(image: Image) -> Favorite? {
    return manager.getFavorite(image: image)
  }
  
  func storeFavorites() -> [Image] {
    return self.images
  }
  
  func delete(image: Image) {
    manager.delete(image: image)
  }
  
  func save() {
    manager.save()
  }
}
