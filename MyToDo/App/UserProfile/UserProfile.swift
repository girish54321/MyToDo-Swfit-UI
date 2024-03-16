//
//  UserProfile.swift
//  MyToDo
//
//  Created by Girish Parate on 15/03/24.
//

import SwiftUI
import NetworkImage

func convertDateFormat(inputDate: String) -> String {

     let olDateFormatter = DateFormatter()
     olDateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"

     let oldDate = olDateFormatter.date(from: inputDate)

     let convertDateFormatter = DateFormatter()
     convertDateFormatter.dateFormat = "MMM dd yyyy h:mm a"

     return convertDateFormatter.string(from: oldDate ?? Date())
}


struct UserProfile: View {
    @State private var userData: UserProfileRes?
    @State private var showLogOutAlert = false
    
    @EnvironmentObject var appViewModel: AppViewModel
    @EnvironmentObject var navStack: ProfileNavigationStackViewModal
    @EnvironmentObject var authViewModel: AuthViewModel
    
    @AppStorage(AppConst.isSkipped) var isSkipped: Bool = false
    @AppStorage(AppConst.token) var token: String = ""
    
    var body: some View {
        NavigationStack (path: $navStack.presentedScreen) {
            List {
                Section {
                    VStack (alignment: .leading){
                        HStack {
                            VStack (alignment: .leading, spacing: 16) {
                                HStack {
                                    Text(userData?.users?[0].firstName ?? "Loading")
                                    Text(userData?.users?[0].lastName ?? "Loading")
                                }
                                Text(userData?.users?[0].email ?? "Loading")
                            }
                            Spacer()
                            NetworkImage(url: URL(string: AppConst.todoimagesPath + (userData?.users?[0].profileimage ?? "Loading"))) { image in
                                image
                                    .resizable()
                                .scaledToFill()
                            } placeholder: {
                                    ZStack {
                                        Color.secondary.opacity(0.25)
                                        Image(systemName: "photo.fill")
                                            .imageScale(.large)
                                            .blendMode(.overlay)
                                    }
                                }
                                .frame(width: 100, height: 100)
                                .clipped()
                                .clipShape(Circle())
                        }
                    }
                }
                Section {
                    HStack {
                        Text("Joined At")
                        Spacer()
                        Text(convertDateFormat(inputDate: userData?.users?[0].createdAt ?? "Some data"))
                    }
                    HStack {
                        Text("Update At")
                        Spacer()
                        Text(convertDateFormat(inputDate: userData?.users?[0].updatedAt ?? "Some data"))
                    }
                   
                }
                Button("Logout!", action: {
                    showLogOutAlert.toggle()
                })
                .foregroundColor(.red)
                .navigationBarItems(
                    trailing:
                            Button(action: {
                                let data = EditProfileScreenType(userData: userData)
                                navStack.presentedScreen.append(data)
                            }) {
                                Image(systemName: AppIconsSF.settingsIcon)
                            }
                )
                .navigationTitle("User Profile")
                .navigationDestination(for: EditProfileScreenType.self) { type in
                    EditProfile(userData:(userData?.users![0])!)
                }
                .alert(isPresented: $showLogOutAlert) {
                    Alert(title: Text("Log out?"),
                          message: Text("Are you sure you want to logout out? Press 'OK' to confirm or 'Cancel' to stay Logged in."),
                          primaryButton: .destructive(Text("Yes")) {
                        userLogOut()
                    }, secondaryButton: .cancel())
                }
                .onAppear {
                    getUserProfile()
                }
            }
        }
    }
    
    func userLogOut()  {
        authViewModel.userState = nil
        authViewModel.token = ""
        authViewModel.isLoggedIn = false
        isSkipped = false
        token = ""
    }
    
    func getUserProfile() {
        UserServise().getProfile(parameters: nil) {
            result in
            switch result {
            case .success(let data):
                userData = data
            case .failure(let error):
                print("User Profile Error")
                print(error)
                switch error {
                case .NetworkErrorAPIError(let errorMessage):
                    appViewModel.errorMessage = errorMessage
                case .BadURL: break
                case .NoData: break
                case .DecodingError: break
                }
            }
        }
    }
}

//struct UserProfile_Previews: PreviewProvider {
//    static var previews: some View {
//            UserProfile()
//    }
//}
