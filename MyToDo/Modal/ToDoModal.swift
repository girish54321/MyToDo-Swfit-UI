//
//  ToDoModal.swift
//  MyToDo
//
//  Created by Girish Parate on 09/03/24.
//

import Foundation
// MARK: - ToDo
struct ToDo: Codable {
    var totalPages, total, perPage, page: Int?
    var todo: [TodoItem]?

    enum CodingKeys: String, CodingKey {
           case totalPages = "total_pages"
           case total
           case perPage = "per_page"
           case page, todo
       }
}

struct SelectedToDoType: Codable {
    var todo: TodoItem?
}


// MARK: - Todo
struct TodoItem: Codable, Identifiable, Hashable {
    var id:String = UUID().uuidString
    var toDoId: String?
    var title, body, state: String?
    var userID: String?
    var createdAt, updatedAt: String?
    let files: [File?]?

    enum CodingKeys: String, CodingKey {
        case toDoId, title, body, state
        case userID = "userId"
        case createdAt, updatedAt
        case files
    }
}

struct File: Codable, Hashable {
    var id:String = UUID().uuidString
    let fileID, fileName, fileSize, type: String?
    let createdAt, updatedAt, toDoID, userID: String?

    enum CodingKeys: String, CodingKey {
        case fileID = "fileId"
        case fileName, fileSize, type, createdAt, updatedAt
        case toDoID = "toDoId"
        case userID = "userId"
    }
}
