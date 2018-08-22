//
//  TemperatureUnit.swift
//  Sunblock
//
//  Created by Suthananth Arulanatham on 21.08.2018.
//  Copyright © 2018 Shortcut. All rights reserved.
//

import Foundation

enum TemperatureUnit{

    case celcius
    case fahrenheit

    init(value: Int){
        switch value{
        case 1: self = .fahrenheit
        default: self = .celcius
        }
    }

    func convertToFahrenheit(celcius: Double) -> Double {
        return (celcius * (9 / 5)) + 32
    }

    func convertToCelcius(fahrenheit: Double) -> Double{
        return (fahrenheit - 32) * (5 / 9)
    }

    var intValue: Int{
        switch self{
        case .celcius: return 0
        case .fahrenheit: return 1
        }
    }

    var description : String {
        let preText = "Temperature is shown as "
        switch self {
        case .celcius: return preText + "Celcius(℃)"
        case .fahrenheit: return preText + "Fahrenheit(℉)"
        }
    }
}
