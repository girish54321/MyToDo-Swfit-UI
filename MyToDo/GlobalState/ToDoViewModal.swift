//
//  ToDoViewModal.swift
//  MyToDo
//
//  Created by Girish Parate on 10/03/24.
//

import Foundation
import SwiftUI
import Combine
import Alamofire

class ToDoViewModal: ObservableObject {
    
    @Published var selectedTodo: TodoItem? = nil
    @Published var toDoListData: ToDo? = nil
    
    init() {
        getUserNotes()
    }
    
    func pickToDo(data:TodoItem?)  {
        selectedTodo = data
    }
    
    //MARK: Get All ToDo
    func getUserNotes() {
        ToDoServices().getUserToDo(parameters: nil) {
            result in
            switch result {
            case .success(let data):
                self.toDoListData = data
            case .failure(let error):
                print("Get Notes Error")
                print(error)
                switch error {
                case .NetworkErrorAPIError(let errorMessage):
                    print(errorMessage)
                case .BadURL: break
                case .NoData: break
                case .DecodingError: break
                }
            }
        }
    }
    
    //MARK: Create Todo with Image
    func createTodo(postData: [String: String], completion: @escaping(AddToDo?,String?)->()) {
        ToDoServices().createToDo(parameters: postData)  {
            result in
            switch result {
            case .success(_):
                completion(nil,nil)
            case .failure(let error):
                switch error {
                case .NetworkErrorAPIError(let errorMessage):
                    completion(nil,errorMessage)
                case .BadURL: break
                case .NoData: break
                case .DecodingError: break
                }
            }
        }
    }
    
    //MARK: Update Todo
    func updateTodo(imageData: Data?,postData: [String: String], completion: @escaping(AddToDo?,String?)->()) {
        ToDoServices().updateToDo(parameters: postData)  {
            result in
            switch result {
            case .success(let res):
                completion(res,nil)
            case .failure(let error):
                switch error {
                case .NetworkErrorAPIError(let errorMessage):
                    completion(nil,errorMessage)
                case .BadURL: break
                case .NoData: break
                case .DecodingError: break
                }
            }
        }
    }
    
    //MARK: Delete ToDo
    func deleteTodo(completion: @escaping(MutationResponse?,String?)->()) {
        ToDoServices().deleteToDo(parameters: nil, endpoint: String(selectedTodo?.id ?? "1")) {
            result in
            switch result {
            case .success(let data):
                completion(data,nil)
            case .failure(let error):
                switch error {
                case .NetworkErrorAPIError(let errorMessage):
                    completion(nil,errorMessage)
                case .BadURL: break
                case .NoData: break
                case .DecodingError: break
                }
            }
        }
    }
}

