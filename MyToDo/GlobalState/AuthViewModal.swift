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
//    @Published var userArticle: TrendingArticles? = nil
    @Published var isLoading: Bool = true
    
    init() {
        getProfile()
    }
    
    func saveUser(data:LoginSuccess)  {
        userState = data
    }
    
    func getProfile() {
//        AuthServices().getUser(parameters: nil) {
//            result in
//            switch result {
//            case .success(let data):
//                self.userState = data
//                self.isLoggedIn = true
//                self.isLoading = false
//            case .failure(let error):
//                self.userState = nil
//                self.isLoggedIn = false
//                self.isLoading = false
//                switch error {
//                case .NetworkErrorAPIError(let errorMessage):
//                    print(errorMessage)
//                case .BadURL:
//                    print("BadURL")
//                case .NoData:
//                    print("NoData")
//                case .DecodingError:
//                    print("DecodingError")
//                }
//            }
//        }
    }
}

