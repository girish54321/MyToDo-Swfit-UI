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
    var id: String?
    var title: String?
    var body: String?
    var status: String?
    
    func toDictionary() -> [String: Any] {
        let params = ["title": title,"body": body,"id": id,"status":status].compactMapValues { $0 }
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

