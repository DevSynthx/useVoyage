//
//  HttpLogger.swift
//  project-z
//
//  Created by Inyene Etoedia on 12/02/2024.
//

import Foundation
import os

struct NetworkLogger {
    static let logger = Logger(subsystem: Bundle.main.bundleIdentifier!, category: "Network service")
    static func log(request: URLRequest) {
     
        print("----- Request -----")
        if let url = request.url?.absoluteString {
            print("URL: \(url)")
           
            logger.debug("URL--: \(url, privacy: .public)")
        }
    
        if let method = request.httpMethod {
           
            logger.debug("Method: \(method, privacy: .public)")
        }
        if let headers = request.allHTTPHeaderFields {
            print("Headers:")
            logger.info("Headers:")
            for (key, value) in headers {
                print("\(key): \(value)")
                logger.info("\(key): \(value)")
            }
        }
        if let body = request.httpBody, let bodyString = String(data: body, encoding: .utf8) {
        
            print("Body: \(bodyString)")
        }
        print("-------------------")
    }
    
    static func log(response: HTTPURLResponse, data: Data?) {
        print("----- Response -----")
        switch response.statusCode {
        case 200..<300:
            print("Status Code: \(response.statusCode) (Success)")
        case 400..<500:
            print("Status Code: \(response.statusCode) (Client Error)")
        case 500..<600:
            print("Status Code: \(response.statusCode) (Server Error)")
        default:
            print("Status Code: \(response.statusCode) (Unknown)")
        }
        if let headers = response.allHeaderFields as? [String: String] {
            print("Headers:")
            for (key, value) in headers {
                print("\(key): \(value)")
            }
        }
        if let responseData = data, let bodyString = String(data: responseData, encoding: .utf8) {
            print("Body: \(bodyString)")
        }
        print("--------------------")
    }
}

