//
//  ToDoEndpoint.swift
//  MyToDo
//
//  Created by Girish Parate on 09/03/24.
//

import Foundation
class ToDoApiEndpoint {
    
    enum ToDoApiType {
        case getToDo
        case addTodo
        case delete
    }
    
    func createEndPoint(endPoint: ToDoApiType) -> String {
        switch endPoint {
        case .getToDo:
            return createApi(endPoint: "todo/gettodo")
        case .addTodo:
            return createApi(endPoint: "todo/addtodo")
        case .delete:
            return createApi(endPoint: "todo/deletetodo/")
        }
    }
    
    func createApi(endPoint: String) -> String {
        return AppConst.ApiConst().apiEndPoint + endPoint
    }
}
