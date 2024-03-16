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
    
    @State private var avatarItem: PhotosPickerItem?
    @State private var avatarImage: Image?
    
    @EnvironmentObject var authViewModel: AuthViewModel
    @EnvironmentObject var todoViewModal: ToDoViewModal
    @EnvironmentObject var appViewModel: AppViewModel
    @EnvironmentObject var navStack: ToDoNavigationStackViewModal
    
    var body: some View {
        VStack {
            ToDoForm(titleText:$todo.title.toUnwrapped(defaultValue: ""),
                     bodyText: $todo.body.toUnwrapped(defaultValue: ""),
                     avatarItem: $avatarItem,
                     avatarImage: $avatarImage,
                     onSubmit: {
                        update()
                    }
                )
        }
        .navigationTitle("Update ToDo")
    }
    
    func update() {
        appViewModel.toggle()
        let postData = AddToDoParams(id: String(todo.id ?? 2), title: todo.title,body: todo.body)
        ToDoServices().updateToDo(parameters: postData.toDictionary()) {
            result in
            switch result {
            case .success(let data):
                let upDatedToto = todo
                todoViewModal.selectedTodo = upDatedToto
                appViewModel.toggle()
                navStack.presentedScreen.removeLast()
            case .failure(let error):
                print("Update todo Error")
                print(error)
                switch error {
                case .NetworkErrorAPIError(let errorMessage):
                    appViewModel.toggle()
                    appViewModel.errorMessage = errorMessage
                    print(errorMessage)
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
