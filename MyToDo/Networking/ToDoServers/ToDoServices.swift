//
//  ToDoServices.swift
//  MyToDo
//
//  Created by Girish Parate on 09/03/24.
//

import Foundation
import Alamofire
class ToDoServices {
    
    func getUserToDo (
        parameters: Parameters?,
        completion: @escaping(Result<ToDo,NetworkError>) -> Void){
            return RestAPIClient.request(type: ToDo.self,
                                         endPoint: ToDoApiEndpoint().createEndPoint(endPoint: .getToDo),
                                         method:.get,
                                         parameters:parameters,
                                         completion: completion
            )
        }
    
    func getSelectedToDo (
        parameters: Parameters?,
        completion: @escaping(Result<SelectedToDoType,NetworkError>) -> Void){
            return RestAPIClient.request(type: SelectedToDoType.self,
                                         endPoint: ToDoApiEndpoint().createEndPoint(endPoint: .getToDo),
                                         method:.get,
                                         parameters:parameters,
                                         completion: completion
            )
        }
    
    func createToDo (
        parameters: Parameters?,
        completion: @escaping(Result<AddToDo,NetworkError>) -> Void){
            return RestAPIClient.request(type: AddToDo.self,
                                         endPoint: ToDoApiEndpoint().createEndPoint(endPoint: .addTodo),
                                         method:.post,
                                         parameters:parameters,
                                         completion: completion
            )
        }
    
    func updateToDo (
        parameters: Parameters?,
        completion: @escaping(Result<AddToDo,NetworkError>) -> Void){
            return RestAPIClient.request(type: AddToDo.self,
                                         endPoint: ToDoApiEndpoint().createEndPoint(endPoint: .updateTodo),
                                         method:.post,
                                         parameters:parameters,
                                         completion: completion
            )
        }
    
    func deleteToDo (
        parameters: Parameters?,
        endpoint: String,
        completion: @escaping(Result<MutationResponse,NetworkError>) -> Void){
            return RestAPIClient.request(type: MutationResponse.self,
                                         endPoint: "\(ToDoApiEndpoint().createEndPoint(endPoint: .delete))\(endpoint)",
                                         method:.delete,
                                         parameters:parameters,
                                         completion: completion
            )
        }
}
