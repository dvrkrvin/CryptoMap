//
//  CoinCapAPI.swift
//  Project3
//
//  Created by Lincoln Stewart on 11/7/22.
//

import Foundation

struct CoinMapAPI {
    
    static let retrieveVenuesURLString = "https://coinmap.org/api/v1/venues/?limit=100"
    
    static func venues(fromJSON data: Data) -> Result<[Venue], Error> {
        do {
            let decoder = JSONDecoder()
            
            let coinMapResponse = try decoder.decode(CoinMapResponse.self, from: data)
            return .success(coinMapResponse.venues)
            
        } catch {
            return .failure(error)
        }
    }
}

struct CoinMapResponse: Codable {
    let venues: [Venue]
}
