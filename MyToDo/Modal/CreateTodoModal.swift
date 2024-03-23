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
    var deleteFile: Bool?
    
    func toDictionary() -> [String: String] {
        var params = [String: String]()
        if let id = id {
            params["id"] = id
        }
        if let title = title {
            params["title"] = title
        }
        if let body = body {
            params["body"] = body
        }
        if let status = status {
            params["status"] = status
        }
        if let deleteFile = deleteFile {
            params["deleteFile"] = String(deleteFile)
        }
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

