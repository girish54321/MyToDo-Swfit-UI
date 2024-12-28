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
                Section {
                    VStack (alignment: .leading){
                        HStack {
                            VStack (alignment: .leading, spacing: 16) {
                                HStack {
                                    Text(authViewModel.userData?.users?.firstName ?? "Loading")
                                    Text(authViewModel.userData?.users?.lastName ?? "Loading")
                                }
                                Text(authViewModel.userData?.users?.email ?? "Loading")
                            }
                            Spacer()
                            NetworkImage(url: URL(string: "https://irs.www.warnerbros.com/gallery-v2-jpeg/movies/node/77906/edit/WW-06907r.jpg")) { image in
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
