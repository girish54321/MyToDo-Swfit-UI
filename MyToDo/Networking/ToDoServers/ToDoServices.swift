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
    
    func createToDoWithImage (
        parameters: Parameters?,
        multipartFormData: @escaping (MultipartFormData) -> Void,
        completion: @escaping(Result<AddToDo,NetworkError>) -> Void){
            return UploadFileClient.request(type: AddToDo.self,
                                            endPoint: ToDoApiEndpoint().createEndPoint(endPoint: .addTodo),
                                            multipartFormData:multipartFormData,
                                            parameters:parameters,
                                            completion: completion
            )
        }
    
    func updateToDoWithImage (
        parameters: Parameters?,
        multipartFormData: @escaping (MultipartFormData) -> Void,
        completion: @escaping(Result<AddToDo,NetworkError>) -> Void){
            return UploadFileClient.request(type: AddToDo.self,
                                         endPoint: ToDoApiEndpoint().createEndPoint(endPoint: .updateTodo),
                                         multipartFormData:multipartFormData,
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
        completion: @escaping(Result<DeleteToDoModal,NetworkError>) -> Void){
            return RestAPIClient.request(type: DeleteToDoModal.self,
                                         endPoint: "\(ToDoApiEndpoint().createEndPoint(endPoint: .delete))\(endpoint)",
                                         method:.delete,
                                         parameters:parameters,
                                         completion: completion
            )
        }
}
