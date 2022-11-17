//
//  AssetStore.swift
//  Project3
//
//  Created by Lincoln Stewart on 11/7/22.
//

import Foundation

class VenueStore {
    
    private let session: URLSession = {
        let config = URLSessionConfiguration.default
        return URLSession(configuration: config)
    }()
    
//    var venues = [Venue]()
    
    func fetchVenues(completion: @escaping (Result<[Venue], Error>) -> Void) {

        guard let url = URL(string: CoinMapAPI.retrieveVenuesURLString) else {
            print("URL conversion failed")
            return
        }
        let request = URLRequest(url: url)
        let task = session.dataTask(with: request) {
            (data, response, error) in

//            if let jsonData = data {
//                if let jsonString = String(data: jsonData,
//                                           encoding: .utf8) {
//                    print(jsonString)
//                }
//            } else if let requestError = error {
//                print("Error fetching venues: \(requestError)")
//            } else {
//                print("Unexpected error with the request")
//            }
            let result = self.processVenuesRequest(data: data, error: error)
            completion(result)
        }
        task.resume()
    }
    
    private func processVenuesRequest(data: Data?, error: Error?) -> Result<[Venue], Error> {
        guard let jsonData = data else {
            return .failure(error!)
        }

        return CoinMapAPI.venues(fromJSON: jsonData)
    }
    
}
