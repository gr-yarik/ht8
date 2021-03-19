//
//  WeatherService.swift
//  SwiftUIWeather
//
//  Created by Yaroslav Hrytsun on 17.03.2021.
//

import Foundation
import Combine

final class WeatherService {
    
    func fetchWeather(forCity city: String) -> AnyPublisher<CurrentCityWeatherData, Error> {
        let name = city.split(separator: " ").joined(separator: "%20")
        let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?q=\(name)&apikey=e9cda96d584413da5ec469f8e2cd042b&units=metric")!
        return URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: CurrentCityWeatherData.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    func checkIfValidCityName(cityName: String, completion: @escaping (Bool) -> ()) {
        let name = cityName.split(separator: " ").joined(separator: "%20")
        let urlString = "https://api.openweathermap.org/data/2.5/weather?q=\(name)&apikey=e9cda96d584413da5ec469f8e2cd042b&units=metric"
        guard let url = URL(string: urlString) else { return }
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url) { (data, responce, error) in
            completion((responce as! HTTPURLResponse).statusCode == 200 ? true : false)
        }
        task.resume()
    }
    
    
}
