//
//  ToDo_ListTests.swift
//  ToDo_ListTests
//
//  Created by Konstantine Tsirgvava on 27.08.24.
//

import XCTest
@testable import ToDo_List

final class ToDo_ListTests: XCTestCase {
    
    var todos: Todos?

    override func setUpWithError() throws {
        // Load the JSON file
        if let url = Bundle(for: type(of: self)).url(forResource: "todos", withExtension: "json") {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            todos = try decoder.decode(Todos.self, from: data)
        }
    }

    override func tearDownWithError() throws {
        todos = nil
    }
    
    func testFirstToDoItem() throws {
        guard let firstToDo = todos?.todos.first else { return }
        XCTAssertEqual(firstToDo.todoTitle, "Do something nice for someone you care about")
        XCTAssertFalse(firstToDo.completed)
    }

    func testCompletedTasksCount() throws {
        let completedTodos = todos?.todos.filter { $0.completed }
        XCTAssertEqual(completedTodos?.count, 15, "There should be 15 completed to-do items")
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
