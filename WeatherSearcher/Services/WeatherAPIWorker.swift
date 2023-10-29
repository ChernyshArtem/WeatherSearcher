//
//  WeatherAPIWorker.swift
//  WeatherSearcher
//
//  Created by Артём Черныш on 26.10.23.
//

import Foundation
import Alamofire

class WeatherAPIWorker {
    static func findWeatherWithMinMaxTemp(city: String,completion: @escaping (WeatherResponse, Double, Double) -> () ) {
        let headers: HTTPHeaders = [
            "X-RapidAPI-Key": "a27f2b7e3cmshca1d4f8766af5c5p16ced7jsndf386e8586ce",
            "X-RapidAPI-Host": "weatherapi-com.p.rapidapi.com"
        ]
        AF.request("https://weatherapi-com.p.rapidapi.com/forecast.json?q=\(city)&days=3", headers: headers).response { response in
            guard let data = response.data else {
                print("RESPONSE_DATA_ERROR")
                return
            }
        
            guard let responseModel = try? JSONDecoder().decode(WeatherResponse.self, from: data) else {
                print("RESPONSE_MODEL_ERROR")
                return
            }

            let temperature = UserDefaults.standard.string(forKey: "temperature")
            if temperature == "°C" {
                var min = Double.greatestFiniteMagnitude
                var max = -Double.greatestFiniteMagnitude
                for hour in responseModel.weatherForecast.dayForecast[0].hourForecast {
                    if min > hour.temperatureInCelsium {
                        min = hour.temperatureInCelsium
                    }
                    if max < hour.temperatureInCelsium {
                        max = hour.temperatureInCelsium
                    }
                }
                completion(responseModel, min, max)
            } else {
                var min = Double.greatestFiniteMagnitude
                var max = -Double.greatestFiniteMagnitude
                for hour in responseModel.weatherForecast.dayForecast[0].hourForecast {
                    if min > hour.temperatureInFarenheit {
                        min = hour.temperatureInFarenheit
                    }
                    if max < hour.temperatureInFarenheit {
                        max = hour.temperatureInFarenheit
                    }
                }
                completion(responseModel, min, max)
            }
        }
    }
}
