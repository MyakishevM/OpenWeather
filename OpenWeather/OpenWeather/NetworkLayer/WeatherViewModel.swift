//
//  WeatherViewModel.swift
//  OpenWeather
//
//  Created by Vitaliy Petrovskiy on 18.07.22.
//

import Foundation

protocol WeatherUpdateDelegate {
    func updateElements()
}

final class WeatherViewModel {
    private let networkManager = FetchWeatherData()
    var updateDelegate: WeatherUpdateDelegate?
    var dataSource: WeatherDTO?


    //TODO: сделать чтобы подтягивалось
    func getDate() {
        networkManager.fetchWeather(lat: 55.234123, long: 37.32154) { [weak self] weather in
            DispatchQueue.global().async {
            self?.dataSource = weather
                self?.updateDelegate?.updateElements()
            }
        }
    }
}
