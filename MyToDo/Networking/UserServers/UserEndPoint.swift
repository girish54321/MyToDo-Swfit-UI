//
//  UserEndPoint.swift
//  MyToDo
//
//  Created by Girish Parate on 15/03/24.
//

import Foundation
class UserEndPoint {
    
    enum UserEndPointType {
        case getProfile
        case updateProfile
        case updateProfileImage
        case deleteAccount
    }
    
    func createEndPoint(endPoint: UserEndPointType) -> String {
        switch endPoint {
        case .getProfile:
            return createApi(endPoint: "profile/user-profile")

        case .updateProfile:
            return createApi(endPoint: "profile/updateprofile")
            
        case .updateProfileImage:
            return createApi(endPoint: "profile/updateprofile")
            
        case .deleteAccount:
            return createApi(endPoint: "profile/deleteaccount")
        }
    }
    
    func createApi(endPoint: String) -> String {
        return AppConst.ApiConst().apiEndPoint + endPoint
    }
}
