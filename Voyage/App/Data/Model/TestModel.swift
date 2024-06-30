//
//  TestModel.swift
//  project-z
//
//  Created by Inyene Etoedia on 13/02/2024.
//

import Foundation


struct Features: Codable {
    let destinationType: String
    let activityInterests: String
    let budgetRange: String
    let travelParty: String
    let climatePreference: String
    let seasonalInterests: String
    
    enum CodingKeys: String, CodingKey {
        case destinationType = "DestinationType"
        case activityInterests = "ActivityInterests"
        case budgetRange = "BudgetRange"
        case travelParty = "TravelParty"
        case climatePreference = "ClimatePreference"
        case seasonalInterests = "SeasonalInterests"
    }
    
    func encodeToJSON() -> Data? {
        do {
            let encoder = JSONEncoder()
            return try encoder.encode(self)
        } catch {
            print("Error encoding JSON: \(error)")
            return nil
        }
    }
    
    static func decodeFromJSON(data: Data) -> Features? {
        do {
            let decoder = JSONDecoder()
            return try decoder.decode(Features.self, from: data)
        } catch {
            print("Error decoding JSON: \(error)")
            return nil
        }
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(destinationType, forKey: .destinationType)
        try container.encode(activityInterests, forKey: .activityInterests)
        try container.encode(budgetRange, forKey: .budgetRange)
        try container.encode(travelParty, forKey: .travelParty)
        try container.encode(climatePreference, forKey: .climatePreference)
        try container.encode(seasonalInterests, forKey: .seasonalInterests)
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        destinationType = try container.decode(String.self, forKey: .destinationType)
        activityInterests = try container.decode(String.self, forKey: .activityInterests)
        budgetRange = try container.decode(String.self, forKey: .budgetRange)
        travelParty = try container.decode(String.self, forKey: .travelParty)
        climatePreference = try container.decode(String.self, forKey: .climatePreference)
        seasonalInterests = try container.decode(String.self, forKey: .seasonalInterests)
    }
}

// Example usage:

// Create an instance of Features
//let features = Features(destinationType: "Type", activityInterests: "Interests", budgetRange: "Range", travelParty: "Party", climatePreference: "Preference", seasonalInterests: "Interests")
//
//// Encode to JSON
//if let jsonData = try? features.encodeToJSON() {
//    // Send jsonData to server
//}
//
//// Decode from JSON
//// Assuming responseData is the Data received from the server
//if let decodedFeatures = try? Features.decodeFromJSON(data: responseData) {
//    // Use decodedFeatures
//}
