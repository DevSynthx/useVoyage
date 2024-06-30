//
//  TestsService.swift
//  project-z
//
//  Created by Inyene Etoedia on 12/02/2024.
//

import Foundation

protocol TestRepository {
    func testCall() async -> Result<Data, Error>
    func testAnotherCall(completion: @escaping (Result<Data, Error>) -> Void)
}

class TestService: TestRepository  {
    @Service private var networkService: HTTPService
    func testAnotherCall(completion: @escaping (Result<Data, Error>) -> Void)  {
        
        let body: [String: Any] = [
            "features": "Beach Snorkeling Luxury Solo Tropical Summer"
        ]
        guard let jsonData = try? JSONSerialization.data(withJSONObject: body) else {
            print("Error converting body to JSON")
            return
        }

        Task{
            do{
                let (data, _) = try await networkService.perform(path: .recommend, method: .POST(body: jsonData))
                completion(.success(data))
            }catch{
                completion(.failure(error))
            }
        }
    }
    
    
  
    
    func testCall() async -> Result<Data, Error> {
        do{
            let (data, _) = try await networkService.perform(path: .recommend, method: .GET)
            
            print(data)
            return .success(data)
        }
        catch{
            let nsErr = error as NSError
            print(nsErr.code)
            return .failure(error)
            
        }
    }
    
}


class TestViewModel: ObservableObject {
    @Service private var testService: TestRepository
    
    func makeAPICall()async{
      _ =  await testService.testCall()
    }
    
    func makePICall() async{
     _ =  await testService.testAnotherCall(completion: { result in
           switch result {
               case .success(let data):
                   print(data)
               case .failure(let err):
                   print(err)
           }
        })
    }
    
    func newAPICall() {
        testService.testAnotherCall { result in
            switch result {
                case .success(let data):
                    print(data)
                case .failure(let err):
                    print(err)
            }
        }
    }
    
    
}
