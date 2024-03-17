//
//  CreateToDo.swift
//  MyToDo
//
//  Created by Girish Parate on 10/03/24.
//

import SwiftUI
import PhotosUI

struct CreateToDo: View {
    @State private var titleText: String = ""
    @State private var bodyText: String = ""
    @State private var todoState: String = "OPEN"
    
    @State private var avatarItem: PhotosPickerItem?
    @State private var avatarImage: Image?
    
    @EnvironmentObject var appViewModel: AppViewModel
    @EnvironmentObject var todoViewModal: ToDoViewModal
    
    var body: some View {
        NavigationStack {
            VStack {
                ToDoForm(titleText: $titleText, bodyText: $bodyText, todoState: $todoState, avatarItem: $avatarItem, avatarImage: $avatarImage, onSubmit: addToDo,iSupDate: false)
            }
            .navigationTitle("Add ToDo")
        }
    }
    
    func addToDo () {
        appViewModel.toggle()
        ToDoServices().createToDo(parameters: AddToDoParams(title: titleText,body: bodyText,status: "OPEN").toDictionary()) {
            result in
            switch result {
            case .success(_):
                appViewModel.toggle()
                titleText = ""
                bodyText = ""
                appViewModel.slectedTabIndex = 0
                todoViewModal.getUserNotes()
            case .failure(let error):
                print("Create Todo Error")
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

struct CreateToDo_Previews: PreviewProvider {
    static var previews: some View {
        CreateToDo()
    }
}
