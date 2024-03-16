//
//  ToDoViewModal.swift
//  MyToDo
//
//  Created by Girish Parate on 10/03/24.
//

import Foundation
import SwiftUI
import Combine

class ToDoViewModal: ObservableObject {
    
    @Published var selectedTodo: TodoItem? = nil
    @Published var toDoListData: ToDo? = nil
    
//    @ObservedObject var appViewModel: AppViewModel
//
//    init(appViewModel: AppViewModel) {
//        self.appViewModel = appViewModel
//    }
       
    
    func pickToDo(data:TodoItem?)  {
        selectedTodo = data
    }
    
    func updateData(data: ToDo) {
        toDoListData = data
//        print(toDoListData.todo![0].body)
    }
    
    func getUserNotes() {
//        appViewModel.errorMessage = "errorMessage"
//        return
        ToDoServices().getUserToDo(parameters: nil) {
            result in
            switch result {
            case .success(let data):
                print("Get Todo done")
                print(data.todo![0].body)
//                self.toDoListData = data
                print("The local data")

                self.updateData(data: data)
            case .failure(let error):
                print("Error man")
                print(error)
                switch error {
                case .NetworkErrorAPIError(let errorMessage):
                    print("Show me error")
//                    self.appViewModel.errorMessage = errorMessage
                case .BadURL: break
                case .NoData: break
                case .DecodingError: break
                }
            }
        }
    }
}

