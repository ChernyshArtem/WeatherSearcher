//
//  WeatherForecast.swift
//  Weather
//
//  Created by Артём Черныш on 20.10.23.
//

import Foundation

struct WeatherForecast: Codable {
    let dayForecast: [DayForecast]
    
    enum CodingKeys: String, CodingKey {
        case dayForecast = "forecastday"
    }
}

struct DayForecast: Codable {
    let hourForecast: [HourForecast]
    enum CodingKeys: String, CodingKey {
        case hourForecast = "hour"
    }
}

struct HourForecast : Codable {

    let time: String
    let temperatureInCelsium: Double
    let temperatureInFarenheit: Double
    let condition: WeatherCondition
    
    enum CodingKeys: String, CodingKey {
        case time                   = "time"
        case temperatureInCelsium   = "temp_c"
        case temperatureInFarenheit = "temp_f"
        case condition              = "condition"
    }
}
