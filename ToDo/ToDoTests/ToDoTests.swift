//
//  ToDoTests.swift
//  ToDoTests
//
//  Created by MCS on 7/24/19.
//  Copyright © 2019 MCS. All rights reserved.
//

import XCTest
@testable import ToDo

class ToDoTests: XCTestCase {

  var sut: CoreDataManager!
  
    override func setUp() {
      super.setUp()
      sut = CoreDataManager()
    }

    override func tearDown() {
      sut = nil
      super.tearDown()
    }


}
