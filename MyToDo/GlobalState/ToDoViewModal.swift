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
    @Published var todoListErrorMessage: String? = nil
    
    init() {
        getUserNotes(){_,_ in 
            
        }
    }
    
    func pickToDo(data:TodoItem?,completion: @escaping(TodoItem?,String?)->())  {
        ToDoServices().getSelectedTodo(parameters: nil, endpoint: data?.toDoId ?? "", completion: {result in
            switch result {
            case .success(let todoData):
                self.selectedTodo = todoData.todo
                completion(todoData.todo,nil)
            case .failure(let error):
                let errorMessage = createApiErrorMessage(errorCase: error)
                completion(nil,errorMessage)
            }
            
        })
    }
    
    //MARK: Get All ToDo
    func getUserNotes(completion: @escaping(ToDo?,String?)->()) {
        self.todoListErrorMessage = nil
        ToDoServices().getUserToDo(parameters: nil) {
            result in
            switch result {
            case .success(let data):
                self.toDoListData = data
                completion(data,nil)
            case .failure(let error):
                let errorMessage = createApiErrorMessage(errorCase: error)
                self.todoListErrorMessage = errorMessage
                completion(nil,errorMessage)
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
    func updateTodo(postData: [String: String], completion: @escaping(AddToDo?,String?)->()) {
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
        ToDoServices().deleteToDo(parameters: nil, endpoint: String(selectedTodo?.toDoId ?? "1")) {
            result in
            switch result {
            case .success(let data):
                print("SUCCES WITH ERROR?")
                completion(data,nil)
            case .failure(let error):
                switch error {
                case .NetworkErrorAPIError(let errorMessage):
                    print("NETWOrKING ERROR")
                    completion(nil,errorMessage)
                case .BadURL:
                    print("BAD URL")
                case .NoData:
                    print("NO Data")
                case .DecodingError:
                    completion(nil,"Decoding Error")
                }
            }
        }
    }
}

