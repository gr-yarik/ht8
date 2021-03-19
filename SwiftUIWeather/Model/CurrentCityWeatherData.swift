//
//  CurrentCityWeatherData.swift
//  SwiftUIWeather
//
//  Created by Yaroslav Hrytsun on 17.03.2021.
//

import Foundation

struct CurrentCityWeatherData: Codable {
    let weather: [Weather]
    let main: Main
    let cityName: String
    let wind: Wind
    
    enum CodingKeys: String, CodingKey {
        case weather
        case main
        case cityName = "name"
        case wind
    }
}

struct Main: Codable {
    let temperature: Double
    let feelsLikeTemperature: Double
    
    enum CodingKeys: String, CodingKey {
        case temperature = "temp"
        case feelsLikeTemperature = "feels_like"
    }
}

struct Weather: Codable {
    let id: Int
}

struct Wind: Codable {
    let speed: Double
}
