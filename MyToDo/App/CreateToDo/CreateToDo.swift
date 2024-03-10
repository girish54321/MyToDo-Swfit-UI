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
    
    @State private var avatarItem: PhotosPickerItem?
    @State private var avatarImage: Image?
    
    @EnvironmentObject var appViewModel: AppViewModel
    
    var body: some View {
        NavigationStack {
            VStack {
                Form {
                    Text("Yes!\n\nYou can do it")
                    Section {
                        TextField("Title", text: $titleText)
                            .textInputAutocapitalization(.never)
                        TextField("Place",text: $bodyText)
                             .frame(minHeight: 100)
                    }
                    Section {
                        HStack {
                            PhotosPicker("Select Image", selection: $avatarItem, matching: .images)
                                .task(id: avatarItem) {
                                    avatarImage = try? await avatarItem?.loadTransferable(type: Image.self)
                                }
                            Spacer()
                            Image(systemName: AppIconsSF.checkMark)
                                .foregroundColor(.accentColor)
                        }
                        avatarImage?
                            .resizable()
                            .scaledToFit()
                    }
                    Section("Save your todo") {
                            Button("Add Todo") {
                                addToDo()
                            }
                        }
            }
            }
            .navigationTitle("Add ToDo")
        }
    }
    
    func addToDo () {
        appViewModel.toggle()
        ToDoServices().createToDo(parameters: AddToDoParams(title: titleText,body: bodyText).toDictionary()) {
            result in
            switch result {
            case .success(let data):
                print("Create todo Done")
                appViewModel.toggle()
                titleText = ""
                bodyText = ""
                appViewModel.slectedTabIndex = 0
            case .failure(let error):
                print("Error man")
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
