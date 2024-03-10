//
//  CreateTodoModal.swift
//  MyToDo
//
//  Created by Girish Parate on 10/03/24.
//

import Foundation

// MARK: - AddToDo
struct AddToDo: Codable {
    let post: TodoItem?
}

struct AddToDoParams {
    var title: String?
    var body: String?
    
    func toDictionary() -> [String: Any] {
        let params = ["title": title,"body": body].compactMapValues { $0 }
        return params
    }
}



struct DeleteoDoParams {
    var id: String
    
    func toDictionary() -> [String: Any] {
        let params = ["id": id]
        return params
    }
}

// MARK: - Welcome
struct DeleteToDoModal: Codable {
    let deleted: Bool?
}

