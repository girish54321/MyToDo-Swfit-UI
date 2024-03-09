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
        
        @AppStorage(AppConst.token) var token: String = ""
        let encodedURL = endPoint.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        var headers: HTTPHeaders? = nil
        if(token != ""){
            headers = [
                "Authorization": "Bearer \(token)",
                "Accept": "application/json"
            ]
        } else {
            headers = nil
        }
        print("DEBUG Only")
        print("API EndPoint")
        print(encodedURL)
        print("Tokan")
        print("Bearer \(token)")
        AF.request(encodedURL,method: method,parameters: parameters,headers: headers)
            .response { response in
                ApiError().handleError(response: response) { result in
                    switch result {
                    case .success(_):
                        DispatchQueue.main.async {
                            if (costumeCompletion != nil) {
                                costumeCompletion!(response.response)
                                return
                            }
                            let statusCode = response.response?.statusCode
                            if(statusCode == 204){
                                completion(.success("Done" as! T))
                                return
                            }
                            if(statusCode == 200 || statusCode == 201){
                                let result = response.result
                                switch result {
                                case .success(let data):
                                    guard let data = data else {
                                        completion(.failure(.NoData))
                                        return
                                    }
                                    do {
                                        let json = try JSONSerialization.jsonObject(with: data) as? [String: Any]
                                    } catch {
                                        print(error)
                                    }
                                    // JSON TO Types
                                    guard let obj = try? JSONDecoder().decode(T.self, from: data) else {
                                        completion(.failure(.DecodingError))
                                        return
                                    }
                                    completion(.success(obj))
                                case .failure(let error):
                                    completion(.failure(.NetworkErrorAPIError(error.localizedDescription)))
                                }
                            } else {
                                guard let jsonData = response.data else {
                                    return
                                }
                                print(jsonData)
//                                do {
//                                    completion(.failure(.NetworkErrorAPIError("Display error")))
//                                } catch {
//                                    print("Error deserializing JSON: \(error)")
//                                    completion(.failure(.NetworkErrorAPIError("Error deserializing JSON")))
//                                }

                                do {
                                    let json = try JSONSerialization.jsonObject(with: jsonData) as? [String: Any]
                                } catch {
                                    print(error)
                                }
                                // JSON TO Types
                                guard let obj = try? JSONDecoder().decode(NetworkErrorC.self, from: jsonData) else {
                                    return
                                }
                                completion(.failure(.NetworkErrorAPIError(obj.error.message)))
                                return
                                
                            }
                        }
                    case .failure(let error):
                        print("Failure: \(error.localizedDescription)")
                        completion(.failure(.NetworkErrorAPIError(error.localizedDescription)))
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
    let error: ErrorC
}

// MARK: - Error
struct ErrorC: Codable {
    let status: Int
    let message: String
}
