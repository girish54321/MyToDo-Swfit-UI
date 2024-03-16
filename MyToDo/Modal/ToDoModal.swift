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

// MARK: - Todo
struct TodoItem: Codable, Identifiable, Hashable {
    var id: Int?
    var title, body, status: String?
    var todoImage: String?
    var userID: Int?
    var createdAt, updatedAt: String?

    enum CodingKeys: String, CodingKey {
        case id, title, body, status, todoImage
        case userID = "userId"
        case createdAt, updatedAt
    }
}
