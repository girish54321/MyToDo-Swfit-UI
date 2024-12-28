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
        
    func deleteAccount (
        parameters: Parameters?,
        completion: @escaping(Result<MutationResponse,NetworkError>) -> Void){
            return RestAPIClient.request(type: MutationResponse.self,
                                         endPoint: (UserEndPoint().createEndPoint(endPoint: .deleteAccount)),
                                         method:.delete,
                                         parameters:parameters,
                                         completion: completion
            )
        }
}
