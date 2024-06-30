//
//  Endpoints.swift
//  project-z
//
//  Created by Inyene Etoedia on 12/02/2024.
//

import Foundation


enum HttpMethod {
    case GET
    case POST(body: Data)
    case PUT
    case DELETE
    case PATCH
}

// https://fe46-41-190-30-2.ngrok-free.app/recommend

enum URLPath: String {
    case recommend = "/recommend"
    case createVehicle = "/vehicle_makes"
    case baseUrl = "https://www.carboninterface.com/api/v1/"
    
}

extension URLPath {
    enum MethodType {
        case get
        case post(data: Data?)
    }
}

extension URLPath {
//    var queryItems: [String: String] {
//         switch self {
//         case .recommendations(let limit, let seedArtists, let seedGenres, let seedTracks):
//             return ["limit": "\(limit)", "seed_artists": seedArtists, "seed_genres": seedGenres, "seed_tracks": seedTracks]
//         case .featuredPlaylist(let offset, let limit):
//             return ["offset":"\(offset)", "limit": "\(limit)"]
//         case .newReleases(let offset, let limit):
//             return ["offset":"\(offset)", "limit": "\(limit)"]
//         case .categories(let offset, let limit):
//             return ["country": "NG", "offset":"\(offset)", "limit": "\(limit)"]
//         case .categoryPlaylists(_, let offset, let limit):
//             return ["offset":"\(offset)", "limit": "\(limit)"]
//         case .search(let query, let offset, let limit):
//             return ["q": query, "type": "album,playlist,track", "offset":"\(offset)", "limit": "\(limit)"]
//         default:
//             return [:]
//         }
//     }
 }













