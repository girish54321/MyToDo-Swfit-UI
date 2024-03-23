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
    
    @State private var todoImagePicker: PhotosPickerItem?
    @State private var todoImage: Image?
    
    @EnvironmentObject var appViewModel: AppViewModel
    @EnvironmentObject var todoViewModal: ToDoViewModal
    
    var body: some View {
        NavigationStack {
            VStack {
                ToDoForm(titleText: $titleText, bodyText: $bodyText, todoState: $todoState, todoImagePicker: $todoImagePicker, todoImage: $todoImage, onSubmit: todoImagePicker != nil ? uploadImage : addToDo, onRemoveImage: onRemoveImage,iSupDate: false)
            }
            .navigationTitle("Add ToDo")
        }
    }
    
    func onRemoveImage () {
        todoImagePicker = nil
        todoImage = nil
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
    
    func uploadImage () {
        Task {
            appViewModel.toggle()
            let imageData = try? await todoImagePicker?.loadTransferable(type: Data.self)
            let postData = AddToDoParams(title: titleText,body: bodyText,status: "OPEN").toDictionary()
            ToDoServices().createToDoWithImage(parameters: postData, multipartFormData: { multipartFormData in
                // Adding image
                multipartFormData.append(imageData!, withName: "todoimage", fileName: "image.jpg", mimeType: "image/jpeg")
                //Adding post data here
                for (key, value) in postData {
                    if let data = value.data(using: .utf8) {
                        multipartFormData.append(data, withName: key)
                    }
                }
            }, completion:  {
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
                    appViewModel.toggle()
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
            })
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
