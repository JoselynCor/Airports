//
//  API.swift
//  newSearchJoselyn
//
//  Created by Joselyn Cordero on 02/08/24.
//

import Foundation

final class APIModel {
        
        let baseUrl = "https://aviation-reference-data.p.rapidapi.com"
        let apiKey = "cbee1b7a7amsh7236e8240980683p176f6ejsnb5c4411941bb"
        let apiHost = "aviation-reference-data.p.rapidapi.com"
        
        func searchAirports(lat: Double, lon: Double, radius: Int, completion: @escaping (Result<[Airport], Error>) -> Void) {
            let endpoint = "/airports/search"
            let urlString = "\(baseUrl)\(endpoint)?lat=\(lat)&lon=\(lon)&radius=\(radius)"
            
            guard let url = URL(string: urlString) else {
                completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])))
                return
            }
            
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            request.setValue(apiKey, forHTTPHeaderField: "X-Rapidapi-Key")
            request.setValue(apiHost, forHTTPHeaderField: "X-Rapidapi-Host")
            request.setValue(apiHost, forHTTPHeaderField: "Host")
            
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    completion(.failure(error))
                    return
                }
                
                guard let data = data else {
                    completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "No data received"])))
                    return
                }
                
                do {
                    let decoder = JSONDecoder()
                    let airports = try decoder.decode([Airport].self, from: data)
                    completion(.success(airports))
                } catch let parsingError {
                    completion(.failure(parsingError))
                }
            }
            
            task.resume()
        }
}


class AirportDataManager {
    static let shared = AirportDataManager()
    
    private init() {}
    
    var airports: [Airport] = []
}
