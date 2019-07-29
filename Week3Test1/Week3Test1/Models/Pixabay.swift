//
//  Pixabay.swift
//  Week3Test1
//
//  Created by MCS on 7/25/19.
//  Copyright © 2019 MCS. All rights reserved.
//

import Foundation

struct Pixabay: Codable {
  let images: [Image]
  
  enum CodingKeys: String, CodingKey {
    case images = "hits"
  }
}
