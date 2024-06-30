//
//  error_handler.swift
//  project-z
//
//  Created by Inyene Etoedia on 12/02/2024.
//

import Foundation

enum ApiError : Error {
    case DecodingError
    case EncodingError
    case URLError
    case errorCode(Int)
    case unknown
}

    extension ApiError : LocalizedError {
        var errorDescription: String? {
            switch self{
            case.DecodingError:
                return "An Error occurred While Decoding"
            case.errorCode( let code):
                return handleError(statusCode: code)
            case .unknown:
                return "An Unknown Error occurred"
            case .EncodingError:
                return "An Error occurred While Encoding"
            case .URLError:
                return "Check the url if that is correct"
            }
        }
        
        
        
        func handleError(statusCode:  Int) -> String {
            switch (statusCode) {
            case 400:
                return "Bad request";
            case 401:
                return "Unauthorized";
            case 403:
                return "Forbidden response";
            case 404:
                return "requested page is not available";
            case 500:
                return "Internal server error";
            case 502:
                return "Bad gateway";
            case 503:
                return "Service unavailable. Please try again later";
            case 422:
                return "An error occurred .. Please try again";
            case 429:
                return "Too many request";
            default:
                return "Oops something went wrong";
            }
        }
    }

extension ApiError: Equatable {
    static func == (lhs: ApiError, rhs: ApiError) -> Bool {
        switch (lhs, rhs) {
        case (.DecodingError, .DecodingError),
            (.EncodingError, .EncodingError),
            (.URLError, .URLError),
             (.unknown, .unknown):
            return true
        case let (.errorCode(code1), .errorCode(code2)):
            return code1 == code2
        default:
            return false
        }
    }
}



extension NetworkService {
    enum APIError: LocalizedError {
        case DecodingError
        case EncodingError
        case URLError
        case errorCode(Int)
        case unknown
    }
}

extension NetworkService.APIError: Equatable {
    
    static func == (lhs: NetworkService.APIError, rhs: NetworkService.APIError) -> Bool {
        switch (lhs, rhs) {
        case (.DecodingError, .DecodingError),
            (.EncodingError, .EncodingError),
            (.URLError, .URLError),
             (.unknown, .unknown):
            return true
        case let (.errorCode(code1), .errorCode(code2)):
            return code1 == code2
        default:
            return false
        }
    }
}

extension NetworkService.APIError {
    
    func handleError(statusCode:  Int) -> String {
        switch (statusCode) {
        case 400:
            return "Bad request";
        case 401:
            return "Unauthorized";
        case 403:
            return "Forbidden response";
        case 404:
            return "requested page is not available";
        case 500:
            return "Internal server error";
        case 502:
            return "Bad gateway";
        case 503:
            return "Service unavailable. Please try again later";
        case 422:
            return "An error occurred .. Please try again";
        case 429:
            return "Too many request";
        default:
            return "Oops something went wrong";
        }
    }
}








