//
//  ImageViewModel.swift
//  Week3Test1
//
//  Created by MCS on 7/29/19.
//  Copyright © 2019 MCS. All rights reserved.
//

import Foundation

public class ImageViewModel {
  
  
  func getImageDetails(image: Image, completion: @escaping (Data, Image) -> Void) {

    if let url = URL(string: image.webformatURL) {
      URLSession.shared.dataTask(with: url) { (data, response, error) in
        guard let data = data else {
          print("Uh Oh... something went wrong.")
          return
        }
        
        completion(data, image)
        }.resume()
    }
    
  }
  
  func getImage(imageURL: String, completion: @escaping (Data) -> Void) {
  
    if let url = URL(string: imageURL) {
      URLSession.shared.dataTask(with: url) { (data, response, error) in
        guard let data = data else {
          print("Uh Oh... something went horribly wrong.")
          return
        }
        completion(data)
      }.resume()
    }
  
  }
  
}
