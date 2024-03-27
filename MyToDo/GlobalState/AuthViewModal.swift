//
//  AuthViewModal.swift
//  MyToDo
//
//  Created by Girish Parate on 09/03/24.
//

import Foundation
import Alamofire
import SwiftUI

class AuthViewModel: ObservableObject {
    
    @Published var isLoggedIn = false
    @Published var userState: LoginSuccess? = nil
    @Published var isLoading: Bool = true
    @Published var userData: UserProfileRes?
    
    @AppStorage(AppConst.isSkipped) var isSkipped: Bool = false
    @AppStorage(AppConst.token) var token: String = ""
    
    init() {
        getUserProfile()
    }
    
    func saveUser(data:LoginSuccess)  {
        userState = data
        token = data.accessToken 
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
                case .BadURL: break
                case .NoData: break
                case .DecodingError: break
                }
            }
        }
    }
    
    //MARK: Create Account
    func createAccount (parameters: Parameters?, completion:  @escaping(LoginSuccess?,String?)->()) {
        AuthServices().createAccount(parameters: parameters) {
            result in
            switch result {
            case .success(let data):
                self.saveUser(data: data)
            case .failure(let error):
                switch error {
                case .NetworkErrorAPIError(let errorMessage):
                    completion(nil,errorMessage)
                    print(errorMessage)
                case .BadURL: break
                case .NoData: break
                case .DecodingError: break
                }
            }
        }
    }
    
    //MARK: Login
    func loginUser (parameters: Parameters?, completion:  @escaping(LoginSuccess?,String?)->()) {
        AuthServices().userLogin(parameters: parameters) {
            result in
            switch result {
            case .success(let data):
                self.saveUser(data: data)
            case .failure(let error):
                switch error {
                case .NetworkErrorAPIError(let errorMessage):
                    completion(nil,errorMessage)
                    print(errorMessage)
                case .BadURL: break
                case .NoData: break
                case .DecodingError: break
                }
            }
        }
    }
}

