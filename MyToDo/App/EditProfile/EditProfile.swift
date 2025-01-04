//
//  EditProfile.swift
//  MyToDo
//
//  Created by Girish Parate on 15/03/24.
//

import SwiftUI
import PhotosUI
import NetworkImage
import SwiftEmailValidator

struct EditProfile: View {
    
    @State private var bodyText: String = ""
    
    @State var userData: Userres
    
    @State private var deleteAlert = false
    
    @EnvironmentObject var navStack: ProfileNavigationStackViewModal
    
    @EnvironmentObject var authViewModel: AuthViewModel
    @EnvironmentObject var todoViewModal: ToDoViewModal
    @EnvironmentObject var appViewModel: AppViewModel
    
    @AppStorage(AppConst.isSkipped) var isSkipped: Bool = false
    @AppStorage(AppConst.token) var token: String = ""
    
    @State private var todoImagePicker: PhotosPickerItem?
    @State private var todoImage: Image?
    
    var body: some View {
        VStack {
            Form {
                Section ("Important") {
                    TextField("Email", text: $userData.email.toUnwrapped(defaultValue: ""))
                        .disabled(true)
                        .textInputAutocapitalization(.never)
                        .textInputAutocapitalization(.never)
                }
                if(!(userData.files?.isEmpty ?? false)){
                    ForEach(userData.files ?? [],id: \.?.id){ item in
                        UserProfileView(onDelete: {
                            deleteLocalProfile()
                        },
                        file: item)
                    }
                }
                Section {
                    VStack (spacing:12) {
                        todoImage?
                            .resizable()
                            .scaledToFit()
                            .cornerRadius(6)
                        PhotosPicker(selection: $todoImagePicker, matching: .images){
                            HStack {
                                Image(systemName: AppIconsSF.attachmentIcon)
                                Text("Update Profile Image")
                            }
                        }
                        .task(id: todoImagePicker) {
                            todoImage = try? await todoImagePicker?.loadTransferable(type: Image.self)
                        }
                    }
                }
                if((userData.files?.isEmpty) == true || todoImage != nil){
                    Section {
                        Button("Delete Profile Image") {
                            todoImage = nil
                            deleteLocalProfile()
                        }
                        .buttonStyle(.automatic)
                        .foregroundColor(.red)
                    }
                }
                Section ("About") {
                    TextField("First Name", text: $userData.firstName.toUnwrapped(defaultValue: ""))
                        .textInputAutocapitalization(.never)
                    TextField("Last Name", text: $userData.lastName.toUnwrapped(defaultValue: ""))
                        .textInputAutocapitalization(.never)
                }
                Section("Save your profile") {
                    Button("SAVE") {
                        updateProfile()
                    }
                }
//                Section("Dont Touch Me") {
//                    Button("Delete Account") {
//                        deleteAlert.toggle()
//                    }
//                    .buttonStyle(.automatic)
//                    .foregroundColor(.red)
//                }
            }
        }
        .alert(isPresented: $deleteAlert) {
            Alert(title: Text("Delete Account?"),
                  message: Text("Are you sure you want to Delete Account? Press 'OK' to confirm or 'Cancel' to keep account"),
                  primaryButton: .destructive(Text("Yes")) {
                deleteAccount()
            }, secondaryButton: .cancel())
        }
        .navigationTitle("Edit Profile")
    }
    
    func deleteLocalProfile(){
        userData.files = nil
    }
    
    func deleteAccount () {
        UserServise().deleteAccount(parameters: nil, completion: {
            result in
            switch result {
            case .success(let deleteRes):
                if(deleteRes.success ?? false){
                    authViewModel.userState = nil
                    authViewModel.token = ""
                    authViewModel.isLoggedIn = false
                    isSkipped = false
                    token = ""
                }
                
            case .failure(let error):
                switch error {
                case .NetworkErrorAPIError(let errorMessage):
                    print(errorMessage)
                case .BadURL: break
                case .NoData: break
                case .DecodingError: break
                }
            }
        })
    }
    
    func updateProfile () {
        Task {
            if EmailSyntaxValidator.correctlyFormatted(userData.email ?? "") {
                let postData = UpdateUserParams(
                    firstName: userData.firstName,
                    lastName: userData.lastName
                )
                let imageData = try? await todoImagePicker?.loadTransferable(type: Data.self)
                AuthViewModel().updateProfile(postData: postData.toDictionary(),imageData: imageData!) {
                    (data, errorText) -> () in
                    if(errorText != nil) {
                        appViewModel.errorMessage = errorText!
                        return
                    }
                    navStack.presentedScreen.removeLast()
                }
            }
        }
    }
}

struct EditProfile_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            EditProfile(userData: Userres(id: 2,firstName: "name", lastName: "last name",email: "Email.com", files: []))
        }
    }
}
