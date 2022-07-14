//
//  WeatherDTO.swift
//  OpenWeather
//
//  Created by Maxim Myakishev on 14.07.2022.
//

import Foundation

struct WeatherDTO: Decodable {
    let timezone: String?
    let current: Current?
}

struct Current: Decodable {

}
