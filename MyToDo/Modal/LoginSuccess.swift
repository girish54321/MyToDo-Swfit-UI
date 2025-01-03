//
//  LoginSuccess.swift
//  MyToDo
//
//  Created by Girish Parate on 09/03/24.
//

import Foundation

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
        return params
    }
}

struct UserProfileRes: Codable {
    var users: Userres?
}

struct UserProfileImageUpdateRes: Codable {
    var user: Userres?
}


struct Userres: Codable {
    var id: Int?
    var userId: String? 
    var firstName, lastName, email: String?
    var profileimage: String?
    var createdAt, updatedAt: String?
    let files: [File?]?
}

struct UpdateUser: Codable {
    var user: Userres?
}

struct UpdateUserParams {
    var firstName: String?
    var lastName: String?
    
    func toDictionary() -> [String: String] {
        let params = ["firstName": firstName,"lastName": lastName].compactMapValues { $0 }
        return params
    }
}
