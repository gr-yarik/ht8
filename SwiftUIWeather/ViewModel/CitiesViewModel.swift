//
//  CitiesViewModel.swift
//  SwiftUIWeather
//
//  Created by Yaroslav Hrytsun on 17.03.2021.
//

import SwiftUI
import Combine

class CitiesViewModel: ObservableObject {
    
    private let weatherService = WeatherService()
    private let storage = Storage()
    
    @Published var citiesWeather = [CititesWeather]()
    
    var cancellable = Set<AnyCancellable>()
    
    init() {
        getWeather()
        NotificationCenter.default.addObserver(self, selector: #selector(getWeather), name: .didAddCity, object: nil)
    }
    
    
    @objc func getWeather() {
        DispatchQueue.main.async {
            self.citiesWeather = []
        }
        storage.$cities
            .sink(receiveValue: fetchWeather(forCities:))
            .store(in: &cancellable)
    }
    
    
    func fetchWeather(forCities cities: [String]) {
        Publishers.MergeMany(cities
            .map(weatherService.fetchWeather(forCity:)))
            .sink { _ in } receiveValue: { weatherData in
                let weather = CititesWeather(currentWeatherData: weatherData)
                self.citiesWeather.append(weather)
            }
            .store(in: &cancellable)
    }
}
