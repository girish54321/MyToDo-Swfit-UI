//
//  ToDoModal.swift
//  MyToDo
//
//  Created by Girish Parate on 09/03/24.
//

import Foundation
// MARK: - ToDo
struct ToDo: Codable {
    let todo: [Todo]?
}

// MARK: - Todo
struct Todo: Codable {
    let id: Int?
    let title, body, status: String?
    let todoImage: String?
    let userID: Int?
    let createdAt, updatedAt: String?

    enum CodingKeys: String, CodingKey {
        case id, title, body, status, todoImage
        case userID = "userId"
        case createdAt, updatedAt
    }
}
