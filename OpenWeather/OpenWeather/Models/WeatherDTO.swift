

import Foundation

struct WeatherDTO: Decodable {
    let timezone: String?
    let current: Current?
}

struct Current: Decodable {

}
