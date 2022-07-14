//
//  FetchWeaherData.swift
//  OpenWeather
//
//  Created by Vitaliy Petrovskiy on 13.07.22.
//

import Foundation

final class FetchWeatherData {
    let networkService = NetworkManager()
    func fetchWeather(city:String, response: @escaping (WeatherDTO?) -> Void) {
        networkService.request(city: "Minsk") { (result) in
            switch result {
            case .success(let data):
                do {
                    let weatherDTO = try JSONDecoder().decode(WeatherDTO.self, from: data)
                    response(weatherDTO)
                    print(weatherDTO)
                } catch let jsonError {
                    print(jsonError)
                }
            case .failure(let error):
                print("Error \(error)")
                response(nil)
            }
        }
    }
}
