//
//  SearchViewModel.swift
//  newSearchJoselyn
//
//  Created by Joselyn Cordero on 02/08/24.
//

import Foundation

struct Airport: Codable {
    let iataCode: String?
    let icaoCode: String
    let name: String
    let longitude: Double
    let latitude: Double
    let alpha2countryCode: String
}

