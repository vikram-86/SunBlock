//
//  WeatherDataResponse.swift
//  Sunblock
//
//  Created by Suthananth Arulanatham on 17.05.2018.
//  Copyright © 2018 Shortcut. All rights reserved.
//

import Foundation

struct WeatherDataResponse: Codable {

    let time		: Int
    let temperature	: Float
    let summary		: String
    let icon		: String
    let uvIndex		: Float
}
