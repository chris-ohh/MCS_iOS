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

  var sut: ToDoViewModel!
  
  override func setUp() {
    super.setUp()
    sut = ToDoViewModel()
  }

  override func tearDown() {
    sut = nil
    super.tearDown()
  }

  func testCreateTask() {
    let task = sut.createNewTasks(with: "test task")
    
    XCTAssertTrue(task is Task)
    XCTAssertEqual("test task", task?.taskDescription)
  }
  
  func testUpdate() {
    let expectedValue = "updated"
    
    sut.createNewTasks(with: "test task")
    
    let testTask = sut.update(at: 0, with: "updated")
    
    XCTAssertEqual(expectedValue, testTask.taskDescription)
  }
  
  func testDelete() {
    let expectedValue = 0
    
    sut.createNewTasks(with: "test task")
    
    let testTasks = sut.delete(at: 0)
    
    XCTAssertEqual(expectedValue, testTasks!.count)
  }
  
  func testGetAllNamedTasks() {
    sut.createNewTasks(with: "eat")
    sut.createNewTasks(with: "sleep")
    sut.createNewTasks(with: "die")
    
    let tasks = sut.getAllTasks(named: "sleep")
    
    XCTAssertEqual("sleep", tasks[0].taskDescription)
    XCTAssertEqual(1, tasks.count)
  }
  
  func testGetAllTasks() {
    sut.createNewTasks(with: "eat")
    sut.createNewTasks(with: "sleep")
    sut.createNewTasks(with: "die")

    let tasks = sut.getAllTasks()

    XCTAssertEqual("eat", tasks[0].taskDescription)
    XCTAssertEqual("sleep", tasks[1].taskDescription)
    XCTAssertEqual("die", tasks[2].taskDescription)
    XCTAssertEqual(3, tasks.count)
  }
  
  func testGetTask() {
    sut.createNewTasks(with: "new task")
    sut.createNewTasks(with: "another task")
    sut.createNewTasks(with: "and another task")
    
    XCTAssertEqual("and another task", sut.getTask(at: 2)?.taskDescription)
  }
  
  func testGetNumberOfTasks() {
    sut.createNewTasks(with: "new task")
    sut.createNewTasks(with: "another task")
    sut.createNewTasks(with: "and another task")
    sut.createNewTasks(with: "eat")
    sut.createNewTasks(with: "sleep")
    sut.createNewTasks(with: "die")
    sut.createNewTasks(with: "ree")
    
    XCTAssertEqual(7, sut.getNumberOfTasks())
  }
  
}
