//
//  Image.swift
//  Week3Test1
//
//  Created by MCS on 7/25/19.
//  Copyright © 2019 MCS. All rights reserved.
//

import Foundation

struct Image: Codable {
  var user: String
  var previewURL: String
  var webformatURL: String
  var likes: Int
  var views: Int
  var comments: Int
  
  enum ImageCodingKeys: String, CodingKey {
    case user
    case previewURL
    case webformatURL
    case likes
    case views
    case comments
  }
  
  init() {
    user = ""
    previewURL = ""
    webformatURL = ""
    likes = 0
    views = 0
    comments = 0
  }
  
  init(from decoder: Decoder) throws {
    let imageContainer = try decoder.container(keyedBy: ImageCodingKeys.self)
    
    self.user = try imageContainer.decode(String.self, forKey: .user)
    self.previewURL = try imageContainer.decode(String.self, forKey: .previewURL)
    self.webformatURL = try imageContainer.decode(String.self, forKey: .webformatURL)
    self.likes = try imageContainer.decode(Int.self, forKey: .likes)
    self.views = try imageContainer.decode(Int.self, forKey: .views)
    self.comments = try imageContainer.decode(Int.self, forKey: .comments)
  }
  
  func encode(to encoder: Encoder) throws {
    var imageContainer = encoder.container(keyedBy: ImageCodingKeys.self)
    
    try imageContainer.encode(self.user, forKey: .user)
    try imageContainer.encode(self.previewURL, forKey: .previewURL)
    try imageContainer.encode(self.webformatURL, forKey: .webformatURL)
    try imageContainer.encode(self.likes, forKey: .likes)
    try imageContainer.encode(self.views, forKey: .views)
    try imageContainer.encode(self.comments, forKey: .comments)
  }
}
