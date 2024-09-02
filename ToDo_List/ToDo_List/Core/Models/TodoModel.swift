//
//  TodoModel.swift
//  ToDo_List
//
//  Created by Konstantine Tsirgvava on 01.09.24.
//

import Foundation

struct Todos: Codable {
    var todos: [Todo]
}

// MARK: - Todo
struct Todo: Codable {
    var todoTitle: String?
    var description: String?
    var createdAt: Date?
    var completed: Bool
    
    enum CodingKeys: String, CodingKey {
        case todoTitle = "todo"
        case description
        case createdAt
        case completed
    }
}
