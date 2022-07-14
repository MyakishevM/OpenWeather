//
//  WeatherDTO.swift
//  OpenWeather
//
//  Created by Maxim Myakishev on 14.07.2022.
//

import Foundation

struct Response: Decodable {
    let list: [WeatherDTO]
}

struct WeatherDTO: Decodable {
    let main: MainWeather?
    let weather: [Weather]?
    let clouds: Clouds?
    let wind: Wind?
    let visibility: Int?
}

struct MainWeather: Decodable {
    let temp: Double?
    let feelsLike: Double?
    let tempMin: Double?
    let tempMax: Double?
    let pressure: Int?
    let seaLevel: Int?
    let grndLevel: Int?
    let humidity: Int?

    enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case pressure
        case seaLevel = "sea_level"
        case grndLevel = "grnd_level"
        case humidity
    }
}

struct Weather: Decodable {
    let main: String?
    let description: String?
}

struct Clouds: Decodable {
    let all: Int?
}

struct Wind: Decodable {
    let speed: Double?
    let deg: Int?
    let gust: Double?
}
