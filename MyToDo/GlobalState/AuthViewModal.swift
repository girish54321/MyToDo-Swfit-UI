//
//  AuthViewModal.swift
//  MyToDo
//
//  Created by Girish Parate on 09/03/24.
//

import Foundation

class AuthViewModel: ObservableObject {
    
    @Published var isLoggedIn = false
    @Published var token: String? = nil
    @Published var userState: LoginSuccess? = nil
    @Published var isLoading: Bool = true
    
    @Published var userData: UserProfileRes?
    
    init() {
        getUserProfile()
    }
    
    func saveUser(data:LoginSuccess)  {
        userState = data
    }
    
    func getUserProfile() {
        UserServise().getProfile(parameters: nil) {
            result in
            switch result {
            case .success(let data):
                self.userData = data
            case .failure(let error):
                print("User Profile Error")
                print(error)
                switch error {
                case .NetworkErrorAPIError(let errorMessage):
                    print(errorMessage)
//                    appViewModel.errorMessage = errorMessage
                case .BadURL: break
                case .NoData: break
                case .DecodingError: break
                }
            }
        }
    }
}

