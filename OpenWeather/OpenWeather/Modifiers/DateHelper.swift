//
//  DateHelper.swift
//  OpenWeather
//
//  Created by Maxim Myakishev on 19.07.2022.
//

import Foundation

struct DateHelper {
    static func formatDateFromIntToString(_ int : Int) -> String {
        let timeInterval = TimeInterval(int)
        let myNSDate = Date(timeIntervalSince1970: timeInterval)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        let date = dateFormatter.string(from: myNSDate)
        return date
    }

    static func formatFromDateToWeekday(_ int: Int) -> String {
        let timeInterval = TimeInterval(int)
        let myNSDate = Date(timeIntervalSince1970: timeInterval)
        let dateFormatter = DateFormatter()
        let weekday =  dateFormatter.weekdaySymbols[Calendar.current.component(.weekday, from: myNSDate) - 1]
        return String(weekday)
    }
}
