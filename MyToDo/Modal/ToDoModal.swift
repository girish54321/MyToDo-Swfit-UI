//
//  ToDoModal.swift
//  MyToDo
//
//  Created by Girish Parate on 09/03/24.
//

import Foundation
// MARK: - ToDo
struct ToDo: Codable {
    var todo: [TodoItem]?
}

struct SelectedToDoType: Codable {
    var todo: TodoItem?
}


// MARK: - Todo
struct TodoItem: Codable, Identifiable, Hashable {
    var id:String = UUID().uuidString
    var toDoId: String?
    var title, body, state: String?
    var todoImage: String? = ""
    var userID: String?
    var createdAt, updatedAt: String?

    enum CodingKeys: String, CodingKey {
        case toDoId, title, body, state, todoImage
        case userID = "userId"
        case createdAt, updatedAt
    }
}

