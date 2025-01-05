//
//  AuthApiEndpoint.swift
//  Conduit
//
//  Created by na on 11/01/23.
//

import Foundation
class AuthApiEndpoint {
    
    enum AuthApiType {
        case login
        case register
        case updateProfile
    }
    
    func createEndPoint(endPoint: AuthApiType) -> String {
        switch endPoint {
        case .login:
            return createApi(endPoint: "auth/login")
        case .register:
            return createApi(endPoint: "auth/signup")
        case .updateProfile:
            return createApi(endPoint: "profile/update-profile")
        }
    }
    
    func createApi(endPoint: String) -> String {
        return AppConst.ApiConst().apiEndPoint + endPoint
    }
}
