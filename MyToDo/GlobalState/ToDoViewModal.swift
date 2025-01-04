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
    @Published var toDoListData: ToDo? = ToDo(totalPages: 10, total: 10, perPage: 1, page: 1, todo: [])
    @Published var todoListErrorMessage: String? = nil
    
    @Published var isLoading: Bool = false
    
    @Published var paggingParams = GetTodoParams(page: 1, size: 10,canLoadMore: true)
    
    init() {
        reloadTodoList()
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
    
  
    func reloadTodoList() {
        let pagging = GetTodoParams(page: 1, size: 10,canLoadMore: true)
        toDoListData?.todo = []
        paggingParams = pagging
        getUserNotes(completion: {_,_ in 
            
        })
    }
    
    //MARK: Get All ToDo
    func getUserNotes(completion: @escaping(ToDo?,String?)->()) {
        self.todoListErrorMessage = nil
        if(isLoading == true || paggingParams.canLoadMore == false) {
            return
        }
        isLoading = true
        ToDoServices().getUserToDo(parameters: paggingParams.toDictionary()) {
            result in
            switch result {
            case .success(let data):
                self.isLoading = false
                self.toDoListData?.page = data.page
                self.toDoListData?.perPage = data.perPage
                self.toDoListData?.total = data.total
                self.toDoListData?.totalPages = data.totalPages
                self.toDoListData?.todo?.append(contentsOf: data.todo!)
                
                let totalPages = data.totalPages ?? 0
                let currentPage = self.paggingParams.page ?? 0

                if totalPages >= currentPage {
                    self.paggingParams.page = currentPage + 1
                    self.paggingParams.canLoadMore = true
                } else {
                    self.paggingParams.canLoadMore = false
                }

                completion(data,nil)
            case .failure(let error):
                self.isLoading = false
                let errorMessage = createApiErrorMessage(errorCase: error)
                self.todoListErrorMessage = errorMessage
                completion(nil,errorMessage)
            }
        }
    }
    
    //MARK: Create Todo with Image
    func createTodo(postData: [String: String],imageData:Data, completion: @escaping(AddToDo?,String?)->()) {
        ToDoServices().createToDo(parameters: postData, multipartFormData: { multipartFormData in
            // Adding image
            multipartFormData.append(imageData, withName: "file", fileName: "image.jpg", mimeType: "image/jpeg")
            //Adding post data here
            for (key, value) in postData {
                if let data = value.data(using: .utf8) {
                    multipartFormData.append(data, withName: key)
                }
            }
        })  {
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
                completion(data,nil)
            case .failure(let error):
                switch error {
                case .NetworkErrorAPIError(let errorMessage):
                    completion(nil,errorMessage)
                case .BadURL:
                    print("Bad Url")
                case .NoData:
                    print("No Data")
                case .DecodingError:
                    completion(nil,"Decoding Error")
                }
            }
        }
    }
}

