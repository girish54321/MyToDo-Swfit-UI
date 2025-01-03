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

struct GetTodoParams {
    var page: Int?
    var size: Int?
    var canLoadMore: Bool
    
    func toDictionary() -> [String: Any] {
        var params = [String: Any]()
        if let page = page {
            params["page"] = page
        }
        if let size = size {
            params["size"] = size
        }
        return params
    }
}


struct AddToDoParams {
    var id: String?
    var title: String?
    var body: String?
    var state: String?
    var deleteFile: Bool?
    
    func toDictionary() -> [String: String] {
        var params = [String: String]()
        if let id = id {
            params["toDoId"] = id
        }
        if let title = title {
            params["title"] = title
        }
        if let body = body {
            params["body"] = body
        }
        if let status = state {
            params["state"] = status
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

struct MutationResponse: Codable {
    let success: Bool?
}

