//
//  EditProfile.swift
//  MyToDo
//
//  Created by Girish Parate on 15/03/24.
//

import SwiftUI
import PhotosUI
import SwiftEmailValidator

struct EditProfile: View {
    
    @State private var bodyText: String = ""
    
    @State var userData: Userres
    
    @State private var avatarItem: PhotosPickerItem?
    @State private var avatarImage: Image?
    
    
    @EnvironmentObject var navStack: ProfileNavigationStackViewModal
    
    @EnvironmentObject var authViewModel: AuthViewModel
    @EnvironmentObject var todoViewModal: ToDoViewModal
    @EnvironmentObject var appViewModel: AppViewModel
    
    var body: some View {
        VStack {
            Form {
                Text("Update Profile")
                Section ("Important") {
                    TextField("Email", text: $userData.email.toUnwrapped(defaultValue: ""))
                        .textInputAutocapitalization(.never)
                        .textInputAutocapitalization(.never)
                }
                Section ("About") {
                    TextField("First Name", text: $userData.firstName.toUnwrapped(defaultValue: ""))
                        .textInputAutocapitalization(.never)
                    TextField("Last Name", text: $userData.lastName.toUnwrapped(defaultValue: ""))
                        .textInputAutocapitalization(.never)
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
                Section("Save your profile") {
                    Button("SAVE") {
                        updateProfile()
                        }
                    }
            }
        }
        .navigationTitle("Edit Profile")
    }
    
    func updateProfile() {
        if EmailSyntaxValidator.correctlyFormatted(userData.email ?? "") {
            let postData = UpdateUserParams(
                                firstName: userData.firstName,
                                lastName: userData.lastName, email: userData.email ?? "")
            
            UserServise().updateProfile(parameters: postData.toDictionary()) {
                result in
                switch result {
                case .success(let data):
                    navStack.presentedScreen.removeLast()
                case .failure(let error):
                    print("Edit Profile Error")
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
        } else {
            appViewModel.errorMessage = "Invaild Email"
        }
    }
}

struct EditProfile_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            EditProfile(userData: Userres())
        }
    }
}
