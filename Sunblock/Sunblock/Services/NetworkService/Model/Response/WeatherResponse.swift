//
//  WeatherResponse.swift
//  Sunblock
//
//  Created by Suthananth Arulanatham on 17.05.2018.
//  Copyright © 2018 Shortcut. All rights reserved.
//

import Foundation

struct WeatherResponse: Codable{

    let time		: Int
    let summary 	: String
    let temperature	: Float
    let uvIndex		: Float
    let icon		: String
    
}
