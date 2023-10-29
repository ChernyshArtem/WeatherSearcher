//
//  MainViewModel.swift
//  WeatherSearcher
//
//  Created by Артём Черныш on 26.10.23.
//

import Foundation

protocol MainViewModelInterface {
    var model: MainModel { get }
    
    func refreshModelData()
}

class MainViewModel: MainViewModelInterface {
    
    var model: MainModel
    init() {
        model = MainModel()
        refreshModelData()
    }
    
    func refreshModelData() {
        WeatherAPIWorker.findWeatherWithMinMaxTemp { [weak self] response, min, max  in
            
            self?.takeDataFromUserDafeaults(response: response)
            self?.model.humidity.accept(response.weatherInfo.humidity)
            self?.model.cloud.accept(response.weatherInfo.cloud)
            self?.model.city.accept(response.weatherLoaction.cityName)
            self?.model.weatherTitleName.accept(response.weatherInfo.condition.weatherTitleName)
            self?.model.diapasoneMin.accept(min)
            self?.model.diapasoneMax.accept(max)

        }
    }

    private func takeDataFromUserDafeaults(response: WeatherResponse) {
        var temperature   = UserDefaults.standard.string(forKey: "temperature")
        var length        = UserDefaults.standard.string(forKey: "length")
        var pressure      = UserDefaults.standard.string(forKey: "pressure")
        var precipitation = UserDefaults.standard.string(forKey: "precipitation")

        if temperature == "°C" {
            model.degrees.accept(response.weatherInfo.temperatureCelsius)
            model.feelsLike.accept(response.weatherInfo.feelsLikeInCelsius)
            model.arrayOfTableData.accept(fillArrayOfWeatherTableDataCelsius(array: response.weatherForecast.dayForecast))
        } else {
            model.degrees.accept(response.weatherInfo.temperatureFahrenheit)
            model.feelsLike.accept(response.weatherInfo.feelsLikeInFahrenheit)
            model.arrayOfTableData.accept(fillArrayOfWeatherTableDataFahrenheit(array: response.weatherForecast.dayForecast))
        }
        if length == "km" {
            model.wind.accept(response.weatherInfo.windInKilometres)
            model.visible.accept(response.weatherInfo.visibleInKiloMeters)
            model.gust.accept(response.weatherInfo.gustInKilometerPerHour)
        } else {
            model.wind.accept(response.weatherInfo.windInMiles)
            model.visible.accept(response.weatherInfo.visibleInMiles)
            model.gust.accept(response.weatherInfo.gustInMilesPerHour)
        }
        if pressure == "mb" {
            model.pressure.accept(response.weatherInfo.pressureInMillibars)
        } else {
            model.pressure.accept(response.weatherInfo.pressureInInches)
        }
        if precipitation == "mm" {
            model.precipitation.accept(response.weatherInfo.precipitationInMillimeters)
        } else {
            model.precipitation.accept(response.weatherInfo.pressureInInches)
        }
    }
    
    private func fillArrayOfWeatherTableDataCelsius (array: [DayForecast]) -> [WeatherTableData] {
        let actualHour = Calendar.current.component(.hour, from: Date())
        var arr: [WeatherTableData] = []
        for (index, day) in array.enumerated() {
            for (hourNumber, hour) in day.hourForecast.enumerated() {
                if index != 0 || actualHour <= hourNumber  {
                    arr.append(WeatherTableData(imageURL: hour.condition.weatherIconURL,
                                                                         temperature: hour.temperatureInCelsium,
                                                                         hour: hourNumber))
                }
            }
        }
        return arr
    }
    
    private func fillArrayOfWeatherTableDataFahrenheit (array: [DayForecast]) -> [WeatherTableData] {
        let actualHour = Calendar.current.component(.hour, from: Date())
        var arr: [WeatherTableData] = []
        for (index, day) in array.enumerated() {
            for (hourNumber, hour) in day.hourForecast.enumerated() {
                if index != 0 || actualHour <= hourNumber  {
                    arr.append(WeatherTableData(imageURL: hour.condition.weatherIconURL,
                                                                         temperature: hour.temperatureInFarenheit,
                                                                         hour: hourNumber))
                }
            }
        }
        return arr
    }
}
