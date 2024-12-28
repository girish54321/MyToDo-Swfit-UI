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
    
    var body: some View {
        NavigationStack {
            VStack {
                ToDoForm(titleText: $titleText, bodyText: $bodyText, todoState: $todoState, onSubmit: addTodo, isUpDate: false)
            }
            .navigationTitle("Add ToDo")
        }
    }

    
    func addTodo () {
        Task {
            appViewModel.toggle()
            let postData = AddToDoParams(title: titleText,body: bodyText,state: "pending").toDictionary()
            todoViewModal.createTodo(postData: postData){
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
                todoViewModal.getUserNotes()
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
