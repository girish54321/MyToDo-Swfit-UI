//
//  UserProfile.swift
//  MyToDo
//
//  Created by Girish Parate on 15/03/24.
//

import SwiftUI
import NetworkImage
import SwiftDate

struct UserProfile: View {
  
    @State private var showLogOutAlert = false
    
    @EnvironmentObject var appViewModel: AppViewModel
    @EnvironmentObject var navStack: ProfileNavigationStackViewModal
    @EnvironmentObject var authViewModel: AuthViewModel
    
    @AppStorage(AppConst.isSkipped) var isSkipped: Bool = false
    @AppStorage(AppConst.token) var token: String = ""
    
    let date = DateInRegion()

 
    var body: some View {
        NavigationStack (path: $navStack.presentedScreen) {
            List {
                UserProfileImage(
                    file: authViewModel.userData?.users?.files?.isEmpty ?? true ? nil : authViewModel.userData?.users?.files?[0],
                    userName: authViewModel.userData?.users?.firstName ?? "",
                    lastName: authViewModel.userData?.users?.lastName ?? "",
                    userEmail: authViewModel.userData?.users?.email ?? ""
                )
                Section {
                    HStack {
                        Text("Joined At")
                        Spacer()
                        Text(DateHelper().formDate(date: Date(authViewModel.userData?.users?.createdAt ?? "") ?? Date.now))
                    }
                    HStack {
                        Text("Update At")
                        Spacer()
                        Text(DateHelper().formDate(date: Date(authViewModel.userData?.users?.updatedAt ?? "") ?? Date.now))
                    }
                }
                Button("Logout!", action: {
                    showLogOutAlert.toggle()
                })
                .foregroundColor(.red)
                .navigationBarItems(
                    trailing:
                            Button(action: {
                                let data = EditProfileScreenType(userData: authViewModel.userData)
                                navStack.presentedScreen.append(data)
                            }) {
                                Image(systemName: AppIconsSF.settingsIcon)
                            }
                )
                .navigationTitle("User Profile")
                .alert(isPresented: $showLogOutAlert) {
                    Alert(title: Text("Log out?"),
                          message: Text("Are you sure you want to logout out? Press 'OK' to confirm or 'Cancel' to stay Logged in."),
                          primaryButton: .destructive(Text("Yes")) {
                        userLogOut()
                    }, secondaryButton: .cancel())
                }
            }
            .refreshable {
                authViewModel.getUserProfile()
                               }
            .navigationDestination(for: EditProfileScreenType.self) { type in
                    EditProfile(userData:(authViewModel.userData?.users)!)
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
}

//struct UserProfile_Previews: PreviewProvider {
//    static var previews: some View {
//            UserProfile()
//    }
//}
