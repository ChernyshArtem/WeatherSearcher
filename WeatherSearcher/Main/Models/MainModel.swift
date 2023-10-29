//
//  MainModel.swift
//  WeatherSearcher
//
//  Created by Артём Черныш on 26.10.23.
//

import Foundation
import RxRelay
class MainModel {
    var city = BehaviorRelay(value: "Default")
    var degrees = BehaviorRelay(value: 0.0)
    var weatherTitleName = BehaviorRelay(value: "Default")
    var diapasoneMin = BehaviorRelay(value: 0.0)
    var diapasoneMax = BehaviorRelay(value: 0.0)
    var arrayOfTableData: BehaviorRelay<[WeatherTableData]> = BehaviorRelay(value: [])
     
    var wind = BehaviorRelay(value: 0.0)
    var pressure = BehaviorRelay(value: 0.0)
    var precipitation = BehaviorRelay(value: 0.0)
    var humidity = BehaviorRelay(value: 0)
    var cloud = BehaviorRelay(value: 0)
    var feelsLike = BehaviorRelay(value: 0.0)
    var visible = BehaviorRelay(value: 0.0)
    var gust = BehaviorRelay(value: 0.0)
    
    var cityForSearch = BehaviorRelay(value: "Minsk")
}
