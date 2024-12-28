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
    
    @State private var avatarItem: PhotosPickerItem?
    @State private var avatarImage: Image?
    
    @EnvironmentObject var navStack: ProfileNavigationStackViewModal
    
    @EnvironmentObject var authViewModel: AuthViewModel
    @EnvironmentObject var todoViewModal: ToDoViewModal
    @EnvironmentObject var appViewModel: AppViewModel
    
    @AppStorage(AppConst.isSkipped) var isSkipped: Bool = false
    @AppStorage(AppConst.token) var token: String = ""
    
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
                if((userData.profileimage?.isEmpty) == nil) {
                    Section {
                        VStack {
                            PhotosPicker("Select Image", selection: $avatarItem, matching: .images)
                                .task(id: avatarItem) {
                                    avatarImage = try? await avatarItem?.loadTransferable(type: Image.self)
                                }
                        }
                        avatarImage?
                            .resizable()
                            .scaledToFit()
                    }
                } else {
                    NetworkImage(url: URL(string: AppConst.todoimagesPath + (userData.profileimage ?? "Loading"))) { image in
                        image
                            .resizable()
                            .scaledToFit()
                    } placeholder: {
                            ZStack {
                                Color.secondary.opacity(0.25)
                                Image(systemName: "photo.fill")
                                    .imageScale(.large)
                                    .blendMode(.overlay)
                            }
                        }
                }
                if (userData.profileimage != nil || avatarImage != nil){
                    Section {
                        Button("Remove Image") {
                            avatarItem = nil
                            userData.profileimage = nil
                        }
                        .buttonStyle(.automatic)
                        .foregroundColor(.red)
                    }
                }
                Section("Save your profile") {
                    Button("SAVE") {
                        updateProfile()
                    }
                }
                
                Section("Dont Touch Me") {
                    Button("Delete Account") {
                        deleteAlert.toggle()
                    }
                    .buttonStyle(.automatic)
                    .foregroundColor(.red)
                }
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
                print(error)
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
            var deleteProfile = "false"
            if(avatarItem == nil && userData.profileimage == nil) {
                deleteProfile = "true"
            }
            if EmailSyntaxValidator.correctlyFormatted(userData.email ?? "") {
                let postData = UpdateUserParams(
                    firstName: userData.firstName,
                    lastName: userData.lastName,
                    email: userData.email ?? "",
                    deleteImage: deleteProfile)
                let imageData = try? await avatarItem?.loadTransferable(type: Data.self)
                
//                authViewModel.updateUserProfile(parameters: postData.toDictionary()){
//                    (data,errorText) -> () in
//                    if(errorText != nil) {
//                        appViewModel.errorMessage = errorText!
//                        return
//                    }
//                    authViewModel.userData?.users![0] = (data?.user!)!
//                    navStack.presentedScreen.removeLast()
//                }
            }
        }
    }
}

struct EditProfile_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            EditProfile(userData: Userres(id: 2,firstName: "name", lastName: "last name",email: "Email.com"))
        }
    }
}
