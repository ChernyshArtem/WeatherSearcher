//
//  WeatherResponse.swift
//  Weather
//
//  Created by Артём Черныш on 20.10.23.
//

import Foundation

struct WeatherResponse: Codable {
    let weatherLoaction: WeatherLocation
    let weatherInfo: WeatherInfo
    let weatherForecast: WeatherForecast
    enum CodingKeys: String, CodingKey {
        case weatherLoaction = "location"
        case weatherInfo     = "current"
        case weatherForecast = "forecast"
    }
}
