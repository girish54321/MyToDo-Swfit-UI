//
//  AuthServices.swift
//  Conduit
//
//  Created by na on 11/01/23.
//

import Foundation
import Alamofire

class AuthServices {
    
    func userLogin (
        parameters: Parameters?,
        completion: @escaping(Result<LoginSuccess,NetworkError>) -> Void){
            return RestAPIClient.request(type: LoginSuccess.self,
                                         endPoint: AuthApiEndpoint().createEndPoint(endPoint: .login),
                                         method:.post,
                                         parameters:parameters,
                                         completion: completion
            )
        }
    
    func createAccount (
        parameters: Parameters?,
        completion: @escaping(Result<LoginSuccess,NetworkError>) -> Void){
            return RestAPIClient.request(type: LoginSuccess.self,
                                         endPoint: AuthApiEndpoint().createEndPoint(endPoint: .register),
                                         method:.post,
                                         parameters:parameters,
                                         completion: completion
            )
        }
    
    func updateProfile (
        parameters: Parameters?,
        completion: @escaping(Result<MutationResponse,NetworkError>) -> Void){
            return RestAPIClient.request(type: MutationResponse.self,
                                         endPoint: AuthApiEndpoint().createEndPoint(endPoint: .updateProfile),
                                         method:.post,
                                         parameters:parameters,
                                         completion: completion
            )
        }
}
