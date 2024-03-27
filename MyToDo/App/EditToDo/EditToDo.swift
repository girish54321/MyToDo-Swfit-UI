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
    
    @State private var todoImagePicker: PhotosPickerItem?
    @State private var todoImage: Image?
    
    @EnvironmentObject var authViewModel: AuthViewModel
    @EnvironmentObject var todoViewModal: ToDoViewModal
    @EnvironmentObject var appViewModel: AppViewModel
    @EnvironmentObject var navStack: ToDoNavigationStackViewModal
    
    var body: some View {
        VStack {
            ToDoForm(titleText:$todo.title.toUnwrapped(defaultValue: ""),
                     bodyText: $todo.body.toUnwrapped(defaultValue: ""),
                     todoState: $todo.status.toUnwrapped(defaultValue: "OPEN"),
                     todoImagePicker: $todoImagePicker,
                     todoImage: $todoImage,
                     imageUrl: todo.todoImage,
                     onSubmit: updateWithImage,
                     onRemoveImage: onRemoveImage
            )
        }
        .navigationTitle("Update ToDo")
    }
    
    func onRemoveImage () {
        todoImagePicker = nil
        todoImage = nil
        if (todo.todoImage != nil){
            todo.todoImage = nil
        }
    }
    
    func updateTodoModal (item: TodoItem) {
        let upDatedToto = item
        todoViewModal.selectedTodo = upDatedToto
        todoViewModal.getUserNotes()
        navStack.presentedScreen.removeLast()
    }
    
    func updateTodoError (errorMessage: String) {
        appViewModel.errorMessage = errorMessage
        print(errorMessage)
    }
    
    func updateWithImage () {
        Task {
            appViewModel.toggle()
            let imageData = try? await todoImagePicker?.loadTransferable(type: Data.self)
            var deleteImage = false
            if(todoImagePicker == nil && todo.todoImage == nil){
                deleteImage = true
            }
            let postData = AddToDoParams(id: String(todo.id ?? 2), title: todo.title,body: todo.body,status: todo.status,deleteFile: deleteImage)

            todoViewModal.updateTodo(imageData: imageData, postData: postData.toDictionary()) {
                (data,errorText) ->() in
                appViewModel.toggle()
                if(errorText != nil) {
                    updateTodoError(errorMessage: errorText!)
                    return
                }
                updateTodoModal(item: data!.post!)
            }
        }
    }
}

struct EditToDo_Previews: PreviewProvider {
    static var previews: some View {
        EditToDo(todo: TodoItem(title: "Hello"))
    }
}
