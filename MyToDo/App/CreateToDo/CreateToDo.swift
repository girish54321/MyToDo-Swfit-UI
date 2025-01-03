//
//  CreateToDo.swift
//  MyToDo
//
//  Created by Girish Parate on 10/03/24.
//

import SwiftUI
import PhotosUI
import Alamofire

struct CreateToDo: View {
    @State private var titleText: String = ""
    @State private var bodyText: String = ""
    @State private var todoState: String = "OPEN"
    
    @EnvironmentObject var appViewModel: AppViewModel
    @EnvironmentObject var todoViewModal: ToDoViewModal
    
    @State private var todoImagePicker: PhotosPickerItem?
    @State private var todoImage: Image?
    
    var body: some View {
        NavigationStack {
            VStack {
                ToDoForm(titleText: $titleText,
                         bodyText: $bodyText,
                         todoState: $todoState, todoImagePicker: $todoImagePicker,
                         todoImage: $todoImage, onSubmit: addTodo,
                         onRemoveImage: onRemoveImage,isUpDate: false)
                
            }
            .navigationTitle("Add ToDo")
        }
    }
    
    func onRemoveImage () {
        todoImagePicker = nil
        todoImage = nil
    }
    
    
    func addTodo () {
        Task {
            appViewModel.toggle()
            let imageData = try? await todoImagePicker?.loadTransferable(type: Data.self)
            let postData = AddToDoParams(title: titleText,body: bodyText,state: "pending").toDictionary()
            todoViewModal.createTodo(postData: postData,imageData: imageData!){
                (data,errorMessage) -> () in
                if(errorMessage != nil) {
                    appViewModel.toggle()
                    appViewModel.errorMessage = errorMessage!
                    return
                }
                appViewModel.toggle()
                titleText = ""
                bodyText = ""
                appViewModel.slectedTabIndex = 0
                todoViewModal.reloadTodoList()
            }
        }
    }
    
}

struct CreateToDo_Previews: PreviewProvider {
    static var previews: some View {
        CreateToDo()
            .environmentObject(AppViewModel())
            .environmentObject(ToDoViewModal())
    }
}
