//
//  NetworkService.swift
//  project-z
//
//  Created by Inyene Etoedia on 12/02/2024.
//

import Foundation
import os


class NetworkService: HTTPService {
    func performReq(path: URLPath, method: HttpMethod, completion: @escaping (Result<Data, Error>) -> Void) {
        let session: URLSession = .customSession
        session.dataTask(with: .makeRequest(path: path, method: method)) { data, urlResponse, error in
         
            var result : Result<Data, Error>
            defer {
                completion(result)
            }
            if let _ = error {
                let error = NSError(domain: "YourDomain", 
                                    code: 0,
                                    userInfo: [NSLocalizedDescriptionKey: "Invalid response"])
                result = .failure(error)
            }
            
            guard  let httpRes = urlResponse as? HTTPURLResponse,
                   (200..<300).contains(httpRes.statusCode) else {
                let statusCode = (urlResponse as? HTTPURLResponse)?.statusCode
                let error = NSError(domain: "YourDomain",
                                    code: statusCode ?? 0,
                                    userInfo: [NSLocalizedDescriptionKey: "HTTP status code not in success range"])
                result = .failure(error)
                return
            }
            
            guard let data = data else {
                let error = NSError(domain: "YourDomain", 
                                    code: httpRes.statusCode,
                                    userInfo: [NSLocalizedDescriptionKey: "HTTP status code not in success range"])
                
                result = .failure(error)
                return
            }
          
            result = .success(data)
        }
        .resume()
    }
    
    func perform(path: URLPath, method: HttpMethod)  async throws -> (Data, URLResponse) {
        let session: URLSession = .customSession
        let (data, response) =  try await session.data(for: .makeRequest(path: path, method: method))
            
            guard  let httpRes = response as? HTTPURLResponse,
                   (200..<300).contains(httpRes.statusCode) else {
                let statusCode = (response as? HTTPURLResponse)?.statusCode
                let error = NSError(domain: "YourDomain", 
                                    code: statusCode ?? 0,
                                    userInfo: [NSLocalizedDescriptionKey: "HTTP status code not in success range"])
                throw error
                
            }
        NetworkLogger.log(response: httpRes, data: data)

//        let jsonObject = try JSONSerialization.jsonObject(with: data, options: [])
//        print("print response\(jsonObject)")
            return (data, response)
    }
    
}

extension URL {
    //https://05f8-104-198-153-32.ngrok-free.app/recommend
    static func withComponents(path: URLPath) -> URL? {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "05f8-104-198-153-32.ngrok-free.app"
        urlComponents.path = "\(path.rawValue)"
        return urlComponents.url
    }
}


extension URLSession {
     static var  customSession: URLSession {
        let configuration = URLSessionConfiguration.default
        configuration.waitsForConnectivity = true
        configuration.timeoutIntervalForRequest = 60
        configuration.timeoutIntervalForResource = 300
        
        return URLSession(configuration: configuration)
    }
}




extension URLRequest {
    static func makeRequest(path: URLPath, method: HttpMethod, bearerToken: String? = nil) -> URLRequest {
        var request = URLRequest(url: .withComponents(path: path)!)
        request.setValue("application/json", forHTTPHeaderField: "Content-type")
        
        if let token = bearerToken {
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }
        
        switch method {
        case .GET:
            request.httpMethod = "GET"
        case .POST(let body):
            request.httpMethod = "POST"
            request.httpBody = body
        case .PUT:
            request.httpMethod = "PUT"
        case .DELETE:
            request.httpMethod = "DELETE"
        case .PATCH:
            request.httpMethod = "PATCH"
                
        }
        
      
        NetworkLogger.log(request: request)

        return request
    }
}


