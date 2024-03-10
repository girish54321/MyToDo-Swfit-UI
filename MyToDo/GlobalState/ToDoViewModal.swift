//
//  ToDoViewModal.swift
//  MyToDo
//
//  Created by Girish Parate on 10/03/24.
//

import Foundation
class ToDoViewModal: ObservableObject {
    @Published var selectedTodo: TodoItem? = nil
    
    func pickToDo(data:TodoItem?)  {
        selectedTodo = data
    }
}

