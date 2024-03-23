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
                     onSubmit: todoImagePicker != nil ? updateWithImage : update,
                     onRemoveImage: onRemoveImage
            )
        }
        .navigationTitle("Update ToDo")
    }
    
    func onRemoveImage () {
        todoImagePicker = nil
        print("What")
        todoImage = nil
        if (todo.todoImage != nil){
            todo.todoImage = nil
        }
    }
    
    func updateTodoModal (item: TodoItem) {
        let upDatedToto = item
        todoViewModal.selectedTodo = upDatedToto
        appViewModel.toggle()
        todoViewModal.getUserNotes()
        navStack.presentedScreen.removeLast()
    }
    
    func updateTodoError (errorMessage: String) {
        appViewModel.toggle()
        appViewModel.errorMessage = errorMessage
        print(errorMessage)
    }
    
    func updateWithImage () {
        Task {
            appViewModel.toggle()
            let imageData = try? await todoImagePicker?.loadTransferable(type: Data.self)
            let postDataParams = AddToDoParams(id: String(todo.id ?? 2), title: todo.title,body: todo.body,status: todo.status).toDictionary()
            ToDoServices().updateToDoWithImage(parameters: postDataParams, multipartFormData: { multipartFormData in
                // Adding image
                multipartFormData.append(imageData!, withName: "todoimage", fileName: "image.jpg", mimeType: "image/jpeg")
                //Adding post data here
                for (key, value) in postDataParams {
                    if let data = value.data(using: .utf8) {
                        multipartFormData.append(data, withName: key)
                    }
                }
            }, completion:  {
                result in
                switch result {
                case .success(let todoRes):
                    updateTodoModal(item: todoRes.post!)
                case .failure(let error):
                    updateTodoError(errorMessage: "Error")
                    switch error {
                    case .NetworkErrorAPIError(let errorMessage):
                        updateTodoError(errorMessage: errorMessage)
                    case .BadURL: break
                    case .NoData: break
                    case .DecodingError: break
                    }
                }
            })
        }
    }
    
    func update() {
        appViewModel.toggle()
        var deleteImage = false
        if(todoImagePicker == nil && todo.todoImage == nil){
            deleteImage = true
        }
        let postData = AddToDoParams(id: String(todo.id ?? 2), title: todo.title,body: todo.body,status: todo.status,deleteFile: deleteImage)
        ToDoServices().updateToDo(parameters: postData.toDictionary()) {
            result in
            switch result {
            case .success(let todoRes):
                updateTodoModal(item: todoRes.post!)
            case .failure(let error):
                print("Update todo Error")
                print(error)
                switch error {
                case .NetworkErrorAPIError(let errorMessage):
                    updateTodoError(errorMessage: errorMessage)
                case .BadURL: break
                case .NoData: break
                case .DecodingError: break
                }
            }
        }
    }
}

struct EditToDo_Previews: PreviewProvider {
    static var previews: some View {
        EditToDo(todo: TodoItem(title: "Hello"))
    }
}
