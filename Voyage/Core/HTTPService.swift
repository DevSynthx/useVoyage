//
//  network.swift
//  project-z
//
//  Created by Inyene Etoedia on 12/02/2024.
//

import Foundation


protocol HTTPService {
    
    //func request(_ endpoint: Endpoint) async throws -> (Data, URLResponse)
    func perform(
        path: URLPath,
        method: HttpMethod) async throws -> (Data, URLResponse)
    
    func performReq(
        path: URLPath,
        method: HttpMethod, completion: @escaping (Result<Data, Error>) -> Void)

}
