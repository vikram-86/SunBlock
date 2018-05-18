//
//  WeatherFeed.swift
//  Sunblock
//
//  Created by Suthananth Arulanatham on 14.05.2018.
//  Copyright © 2018 Shortcut. All rights reserved.
//

import Foundation

enum WeatherFeed{
    case getWeather(UserLocation)
}

extension WeatherFeed: Endpoint{

    var validCodes: [Int] {
        return [200]
    }


    var base: String{
        return "https://api.darksky.net"
    }

    var path: String{
        let urlPath = "/forecast/"
        switch self {
        case .getWeather(let location):
            return urlPath + "\(apiKey)/" + location.coordinateAsString
        }
    }

    var queryItems: [URLQueryItem]{
        var items: [URLQueryItem] = []

        let exclude = URLQueryItem(name: "exclude", value: "minutely,alerts,flags,daily")
        let unit	= URLQueryItem(name: "units", value: "si")
        items.append(contentsOf: [exclude, unit])
        return items
    }
}
