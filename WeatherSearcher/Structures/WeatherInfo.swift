//
//  CurrentWeather.swift
//  Weather
//
//  Created by Артём Черныш on 20.10.23.
//

import Foundation

struct WeatherInfo: Codable {
    let lastUpdatedTimestamp: UInt64
    let lastUpdatedTimeFormatted: String
    let temperatureCelsius: Double
    let temperatureFahrenheit: Double
    let isDay: Double
    let condition: WeatherCondition
    let windInMiles: Double
    let windInKilometres: Double
    let windDegrees: Int
    let windDirection: String
    let pressureInMillibars: Double
    let pressureInInches: Double
    let precipitationInMillimeters: Double
    let precipitationInInches: Double
    let humidity: Int
    let cloud: Int
    let feelsLikeInCelsius: Double
    let feelsLikeInFahrenheit: Double
    let visibleInKiloMeters: Double
    let visibleInMiles: Double
    let uvFactor: Double
    let gustInMilesPerHour: Double
    let gustInKilometerPerHour: Double
            
    enum CodingKeys: String, CodingKey {
        case lastUpdatedTimestamp       = "last_updated_epoch"
        case lastUpdatedTimeFormatted   = "last_updated"
        case temperatureCelsius         = "temp_c"
        case temperatureFahrenheit      = "temp_f"
        case isDay                      = "is_day"
        case condition                  = "condition"
        case windInMiles                = "wind_mph"
        case windInKilometres           = "wind_kph"
        case windDegrees                = "wind_degree"
        case windDirection              = "wind_dir"
        case pressureInMillibars        = "pressure_mb"
        case pressureInInches           = "pressure_in"
        case precipitationInMillimeters = "precip_mm"
        case precipitationInInches      = "precip_in"
        case humidity                   = "humidity"
        case cloud                      = "cloud"
        case feelsLikeInCelsius         = "feelslike_c"
        case feelsLikeInFahrenheit      = "feelslike_f"
        case visibleInKiloMeters        = "vis_km"
        case visibleInMiles             = "vis_miles"
        case uvFactor                   = "uv"
        case gustInMilesPerHour         = "gust_mph"
        case gustInKilometerPerHour     = "gust_kph"
    }
}

struct WeatherCondition: Codable {
    let weatherTitleName: String
    let weatherIconURL: String
    let weatherCode: Int
    
    enum CodingKeys: String, CodingKey {
        case weatherTitleName = "text"
        case weatherIconURL   = "icon"
        case weatherCode      = "code"
    }
}
