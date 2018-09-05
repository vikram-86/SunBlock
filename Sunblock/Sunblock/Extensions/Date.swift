//
//  Date.swift
//  Sunblock
//
//  Created by Suthananth Arulanatham on 18.05.2018.
//  Copyright © 2018 Shortcut. All rights reserved.
//

import Foundation

extension Date{

    static var timeIntervalForCurrentHour: TimeInterval{
        let calendar	= Calendar.current

        let components = calendar.dateComponents([.year, .month,.day,.hour], from: Date())
        let date = calendar.date(from: components)!
        return date.timeIntervalSince1970
    }

    static func isCurrentDay(from timeInterval: TimeInterval) -> Bool{
        let date = Date(timeIntervalSince1970: timeInterval)
        return Calendar.current.isDateInToday(date)
    }

    static func dateString(for timeInterval: TimeInterval)-> String{
        let date = Date(timeIntervalSince1970: timeInterval)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM HH:mm"
        return dateFormatter.string(from: date)
    }

    static func timeString(for timeInterval: TimeInterval) -> String {
        let date = Date(timeIntervalSince1970: timeInterval)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        return dateFormatter.string(from: date)
    }

    static func add(minutes: Int) -> Date{
        let calendar = Calendar.current
        return calendar.date(byAdding: .minute, value: minutes, to: Date())!
    }

    func hasExceeded(duration: Int) -> Bool {
        
        let timeInterval = abs(Date().timeIntervalSince(self))
        return timeInterval >= (Double(duration) *  60000)
    }

    var hourClock: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        return dateFormatter.string(from: self)
    }
}
