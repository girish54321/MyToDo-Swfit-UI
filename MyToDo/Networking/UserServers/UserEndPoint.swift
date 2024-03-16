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
    }
    
    func createEndPoint(endPoint: UserEndPointType) -> String {
        switch endPoint {
        case .getProfile:
            return createApi(endPoint: "users/getprofile")

        case .updateProfile:
            return createApi(endPoint: "users/updateprofile")
        }
    }
    
    func createApi(endPoint: String) -> String {
        return AppConst.ApiConst().apiEndPoint + endPoint
    }
}
