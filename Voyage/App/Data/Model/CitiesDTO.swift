//
//  CitiesDTO.swift
//  project-z
//
//  Created by Inyene Etoedia on 23/06/2024.
//

import Foundation


import Foundation

struct CitiesDTO: Codable,Hashable {
    var name: String = ""
    var country: String = ""
    
    

    static let allCities: [CitiesDTO] = Bundle.main.decode(file: "cities.json")
    static let sampleCodes: CitiesDTO = allCities[0]
}

extension Bundle {
    func decode<T: Decodable>(file: String)  -> T {
        guard let url = self.url(forResource: file, withExtension: nil) else {
           fatalError("could not find file")
        }
        
        guard let data = try? Data(contentsOf: url) else {
            fatalError("could not load file in project")
        }
        
        let decoder = JSONDecoder()
         
        
        guard let result = try? decoder.decode(T.self, from: data) else {
            fatalError("could not decode data")
        }
        return result
        
    }
}





