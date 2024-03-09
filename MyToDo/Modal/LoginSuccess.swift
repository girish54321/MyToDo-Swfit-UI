//
//  LoginSuccess.swift
//  MyToDo
//
//  Created by Girish Parate on 09/03/24.
//

import Foundation

// MARK: - LoginSuccess
struct LoginSuccess: Codable {
    let accessToken, refreshToken: String
}

struct UserAuthParams {
    var firstName: String?
    var lastName: String?
    var email: String
    var password: String
    
    func toDictionary() -> [String: Any] {
        let params = ["firstName": firstName,"lastName": lastName,"email": email, "password": password].compactMapValues { $0 }
//        return ["user": params]
        return params
    }
}
