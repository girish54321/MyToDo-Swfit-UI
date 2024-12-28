//
//  RestAPIClient.swift
//  MyToDo
//
//  Created by Girish Parate on 09/03/24.
//

import Foundation
import Alamofire
import SwiftyJSON
import SwiftUI

// Create API Clinet
class RestAPIClient {
    static func request<T: Codable>(type: T.Type,
                                    endPoint: String,
                                    method: HTTPMethod = .get,
                                    parameters: Parameters? = nil,
                                    completion: @escaping(Result<T,NetworkError>) -> Void,
                                    costumeCompletion: ((HTTPURLResponse?) -> Void)? = nil) {
        // Token
        @AppStorage(AppConst.token) var token: String = ""
        // Crate URL
        let encodedURL = endPoint.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        // Crate Header with Token
        var headers: HTTPHeaders? = nil
        if(token != ""){
            headers = [
                "Authorization": "Bearer \(token)",
                "Accept": "application/json"
            ]
        } else {
            headers = nil
        }
//        UnCommet for Debug
        print("DEBUG Only")
        print("API EndPoint")
        print(encodedURL)
        print("Tokan")
        print("Bearer \(token)")
        print(parameters)
      
        AF.request(encodedURL,method: method,parameters: parameters,headers: headers)
            .response { response in
                ApiError().handleError(response: response) { result in
                    switch result {
                    case .success(_):
                        DispatchQueue.main.async {
                            // if CallBack needed
                            if (costumeCompletion != nil) {
                                costumeCompletion!(response.response)
                                return
                            }
                            // Get Request Status
                            let statusCode = response.response?.statusCode
                            
                            // Handle Stacific Status code
                            if(statusCode == 204){
                                completion(.success("Done" as! T))
                                return
                            }
                            
                            // Default Status
                            if(statusCode == 200 || statusCode == 201){
                                let result = response.result
                                switch result {
                                case .success(let data):
                                    // If No data in Response
                                    guard let data = data else {
                                        completion(.failure(.NoData))
                                        return
                                    }
                                    // JSON TO Types
                                    guard let obj = try? JSONDecoder().decode(T.self, from: data) else {
                                        completion(.failure(.DecodingError))
                                        return
                                    }
                                    // Pass Success with response Type
                                    completion(.success(obj))
                                case .failure(let error):
                                    completion(.failure(.NetworkErrorAPIError(error.localizedDescription)))
                                }
                            } else {
                                print("JSON EROR OLD")
                                // If Error
                                guard let jsonData = response.data else {
                                    return
                                }
                                print("Error JSON")
                                print(jsonData)
                                // JSON TO Types
                                guard let obj = try? JSONDecoder().decode(NetworkErrorC.self, from: jsonData) else {
                                    return
                                }
                                // Pass Error with default Error Type
                                completion(.failure(.NetworkErrorAPIError(obj.error?.message ?? "Error")))
                                return
                                
                            }
                        }
                    case .failure(let error):
                        guard let jsonData = response.data else {
                            return
                        }
                        guard let obj = try? JSONDecoder().decode(NetworkErrorC.self, from: jsonData) else {
                            return
                        }
                        debugPrint(error.localizedDescription)
                        // Pass Error with default Error Type
//                        completion(.failure(.NetworkErrorAPIError(obj.error?.message ?? "Error")))
                        print("Failure: \(error)")
                        completion(.failure(.NetworkErrorAPIError(obj.error?.message ?? error.localizedDescription)))
                    }
                }
                
            }

    }
    
}

// Error Case
enum NetworkError: Error {
    case BadURL
    case NoData
    case DecodingError
    case NetworkErrorAPIError(String)
}

// MARK: - NetworkError
struct NetworkErrorC: Codable {
    let error: ErrorC?
}

// MARK: - Error
struct ErrorC: Codable {
    let status: Int?
    let message: String?
}
