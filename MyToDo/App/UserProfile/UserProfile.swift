//
//  UserProfile.swift
//  MyToDo
//
//  Created by Girish Parate on 15/03/24.
//

import SwiftUI
import NetworkImage

struct UserProfile: View {
    @State private var userData: UserProfileRes?
    
    @EnvironmentObject var appViewModel: AppViewModel
    @EnvironmentObject var navStack: ProfileNavigationStackViewModal
    
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
                        Text("Joined")
                        Spacer()
                        Text(userData?.users?[0].createdAt ?? "Some data")
                    }
                   
                }
                Button("Logout!", action: {
                    
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
//                    EditProfile(userData:userData?.users![0])
                    EditProfile(userData:(userData?.users![0])!)
                }
                .onAppear {
                    getUserProfile()
                }
            }
        }
    }
    
    func getUserProfile() {
        UserServise().getProfile(parameters: nil) {
            result in
            switch result {
            case .success(let data):
                print("I have data")
                userData = data
            case .failure(let error):
                print("Error man")
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
