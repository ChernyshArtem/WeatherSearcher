//
//  WeatherLocation.swift
//  Weather
//
//  Created by Артём Черныш on 20.10.23.
//

import Foundation

struct WeatherLocation: Codable {
    
    let cityName: String
    let regionName: String
    let countryName: String
    let latitude: Double
    let longitude: Double
    let timeZone: String
    let localTimestamp: UInt64
    let localTimeFormatted: String
    
    enum CodingKeys: String, CodingKey {
        case cityName           = "name"
        case regionName         = "region"
        case countryName        = "country"
        case latitude           = "lat"
        case longitude          = "lon"
        case timeZone           = "tz_id"
        case localTimestamp     = "localtime_epoch"
        case localTimeFormatted = "localtime"
    }
}
