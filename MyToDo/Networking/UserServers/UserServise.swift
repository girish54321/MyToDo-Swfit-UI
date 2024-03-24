//
//  UserServise.swift
//  MyToDo
//
//  Created by Girish Parate on 15/03/24.
//

import Foundation
import Alamofire

class UserServise {
    
    func getProfile (
        parameters: Parameters?,
        completion: @escaping(Result<UserProfileRes,NetworkError>) -> Void){
            return RestAPIClient.request(type: UserProfileRes.self,
                                         endPoint: UserEndPoint().createEndPoint(endPoint: .getProfile),
                                         method:.get,
                                         parameters:parameters,
                                         completion: completion
            )
        }
    
    func updateProfile (
        parameters: Parameters?,
        completion: @escaping(Result<UserProfileRes,NetworkError>) -> Void){
            return RestAPIClient.request(type: UserProfileRes.self,
                                         endPoint: UserEndPoint().createEndPoint(endPoint: .updateProfile),
                                         method:.post,
                                         parameters:parameters,
                                         completion: completion
            )
        }
    
    func updateProfileWithImage (
        parameters: Parameters?,
        multipartFormData: @escaping (MultipartFormData) -> Void,
        completion: @escaping(Result<UserProfileImageUpdateRes,NetworkError>) -> Void){
            return UploadFileClient.request(type: UserProfileImageUpdateRes.self,
                                         endPoint: UserEndPoint().createEndPoint(endPoint: .updateProfileImage),
                                         multipartFormData:multipartFormData,
                                         parameters:parameters,
                                         completion: completion
            )
        }
    
    func deleteAccount (
        parameters: Parameters?,
        completion: @escaping(Result<DeleteToDoModal,NetworkError>) -> Void){
            return RestAPIClient.request(type: DeleteToDoModal.self,
                                         endPoint: (UserEndPoint().createEndPoint(endPoint: .deleteAccount)),
                                         method:.delete,
                                         parameters:parameters,
                                         completion: completion
            )
        }
}
