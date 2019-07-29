//
//  BirdViewModel.swift
//  Week3Test1
//
//  Created by MCS on 7/25/19.
//  Copyright © 2019 MCS. All rights reserved.
//

import Foundation

public class BirdViewModel {
  
  let manager = CoreDataManager()
  var images: [Image] = []
  
  func loadBirds(completion: @escaping ([Image]) -> Void) {
    let apiKey = "13137134-163c5df0ef60529937c2e660d"
    let category = "bird"
    let urlString = "https://pixabay.com/api/?key=\(apiKey)&q=\(category)"
    
    guard let pixabyURLString = URL(string: urlString) else { return }
    
    
    URLSession.shared.dataTask(with: pixabyURLString) { (data, response, error) in
      
      guard let data = data,
        let pixaby = try? JSONDecoder().decode(Pixabay.self, from: data) else {
          print("no network :[")
          return
      }
      
      DispatchQueue.main.async {
        self.images = pixaby.images
        completion(self.images)
      }
      
      }.resume()
  }
  
}
