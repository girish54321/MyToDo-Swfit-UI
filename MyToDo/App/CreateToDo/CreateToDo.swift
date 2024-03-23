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
    
    @State private var avatarItem: PhotosPickerItem?
    @State private var avatarImage: Image?
    @State private var avatarImageUi: UIImage?
    
    @EnvironmentObject var appViewModel: AppViewModel
    @EnvironmentObject var todoViewModal: ToDoViewModal
    
    var body: some View {
        NavigationStack {
            VStack {
                ToDoForm(titleText: $titleText, bodyText: $bodyText, todoState: $todoState, avatarItem: $avatarItem, avatarImage: $avatarImage, onSubmit: addToDo,iSupDate: false)
                Button("Upload Image", action: {
                    uploadImage()
                })
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
    
    func uploadImage () {
        Task {
            guard let image = avatarImage else { return }
//            let imageData  = try? await avatarItem?.loadTransferable(type: Image.self)
            let data = try? await avatarItem?.loadTransferable(type: Data.self)
            let parameters = [
                "body": "john_doe",
                "title": "Sample Image Upload"
            ]
            var headers: HTTPHeaders? = nil
             headers = [
                "Authorization": "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJhdWQiOiIxOCIsImlhdCI6MTcxMTE4Mjk0MCwiZXhwIjoxNzExMTg2NTQwLCJpc3MiOiJnaXJpc2guY29tIn0.EyHfy_vbzQ6ZYSuUCh3zNU8ArFeO6ngHNT5KhG3iqco",
                "Accept": "application/json"
            ]
            // Define the endpoint URL
            let url = "http://localhost:5000/api/v1/todo/addtodo"
            
            // Use Alamofire's upload function with multipartFormData to create the request
            AF.upload(
                multipartFormData: { multipartFormData in
                // Add image data to the request
                multipartFormData.append(data!, withName: "todoimage", fileName: "image.jpg", mimeType: "image/jpeg")
                
                // Add other parameters to the request
                for (key, value) in parameters {
                    if let data = value.data(using: .utf8) {
                        multipartFormData.append(data, withName: key)
                    }
                }
            }, to: url,headers: headers)
            .validate() // Optional: Validate the response
            .response { response in
                // Handle the response here
                debugPrint(response)
            }
        }
    }

}

struct CreateToDo_Previews: PreviewProvider {
    static var previews: some View {
        CreateToDo()
    }
}
