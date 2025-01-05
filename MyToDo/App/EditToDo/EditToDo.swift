//
//  EditToDo.swift
//  MyToDo
//
//  Created by Girish Parate on 15/03/24.
//

import SwiftUI
import PhotosUI

struct EditToDo: View {
    
    @State var todo: TodoItem
    
    @EnvironmentObject var authViewModel: AuthViewModel
    @EnvironmentObject var todoViewModal: ToDoViewModal
    @EnvironmentObject var appViewModel: AppViewModel
    @EnvironmentObject var navStack: ToDoNavigationStackViewModal
    
    
    @State private var todoImagePicker: PhotosPickerItem?
    @State private var todoImage: Image?
    
    var body: some View {
        VStack {
            ToDoForm(titleText:$todo.title.toUnwrapped(defaultValue: ""),
                     bodyText: $todo.body.toUnwrapped(defaultValue: ""),
                     todoState: $todo.state.toUnwrapped(defaultValue: "OPEN"),
                     todoImagePicker: $todoImagePicker,
                     todoImage: $todoImage,
                     onSubmit: updateTodo
            )
        }
        .navigationTitle("Update ToDo")
    }
    
    
    func updateTodoModal () {
        todoViewModal.reloadTodoList()
        todoViewModal.pickToDo(data: todo, completion: {_,_ in
            
        })
        navStack.presentedScreen.removeLast()
    }
    
    func updateTodoError (errorMessage: String) {
        appViewModel.errorMessage = errorMessage
        print(errorMessage)
    }
    
    func updateTodo () {
        appViewModel.toggle()
        let postData = AddToDoParams(id: String(todo.toDoId ?? "2"), title: todo.title,body: todo.body,state: todo.state)
        todoViewModal.updateTodo(postData: postData.toDictionary()) {
            (data,errorText) ->() in
            appViewModel.toggle()
            if(errorText != nil) {
                updateTodoError(errorMessage: errorText!)
                return
            }
            updateTodoModal()
        }
    }
}

struct EditToDo_Previews: PreviewProvider {
    static var previews: some View {
        EditToDo(todo: TodoItem(title: "Hello",files: nil))
    }
}
