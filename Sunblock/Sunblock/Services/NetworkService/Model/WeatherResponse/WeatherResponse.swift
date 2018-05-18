//
//  WeatherResponse.swift
//  Sunblock
//
//  Created by Suthananth Arulanatham on 17.05.2018.
//  Copyright © 2018 Shortcut. All rights reserved.
//

import Foundation

struct WeatherResponse: Codable {
    let currently	: WeatherDataResponse
    let hourly		: WeatherHourlyResponse
}
