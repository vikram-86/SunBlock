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
}
