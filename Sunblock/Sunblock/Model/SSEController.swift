//
//  SSEController.swift
//  Sunblock
//
//  Created by Suthananth Arulanatham on 22.05.2018.
//  Copyright © 2018 Shortcut. All rights reserved.
//

import UIKit
typealias SSEValue = (duration: String, unit:String)
struct SSEController{

    let weather		: Weather
    let environment	: Environment
    let skinType	: SkinType
    let spf			: Int

    var uvIcon: UIImage{
        return #imageLiteral(resourceName: "icWeatherSun")
    }

    var weatherIcon: UIImage{
        switch weather.icon{
        case "clear-day"			: return #imageLiteral(resourceName: "icWeatherSun")
        case "clear-night"			: return #imageLiteral(resourceName: "icWeatherMoon")
        case "rain"					: return #imageLiteral(resourceName: "icWeatherRain")
        case "snow"					: return #imageLiteral(resourceName: "icWeatherSnow")
        case "sleet"				: return #imageLiteral(resourceName: "icWeatherSnow")
        case "wind"					: return #imageLiteral(resourceName: "icWeatherWindy")
        case "fog"					: return #imageLiteral(resourceName: "icWeatherFog")
        case "cloudy"				: return #imageLiteral(resourceName: "icWeatherCloud")
        case "partly-cloudy-day"	: return #imageLiteral(resourceName: "icWeatherCloudedAndSun")
        case "partly-cloudy-night"	: return #imageLiteral(resourceName: "icWeatherCloudedNight")
        default						: return #imageLiteral(resourceName: "icWeatherCloud")

        }
    }

    var temperature: String {
        let currentTemperature = round(weather.temperature)
        return "\(Int(currentTemperature))°"
    }

    var uvIndex: String {
        return "\(Int(weather.uvIndex))"
    }

    var title: String {
        switch (Int(weather.uvIndex)){
        case 0...2:
            return "If sunny get some shades on!"
        case 3...5:
            return "When strongest find shade."
        case 6...7:
            return "Put on some sunscreen."
        case 8...10:
            return "You'll have this color soon."
        default:
            return "You'll burn quick!"
        }
    }

    var subTitle: String {
        switch (Int(weather.uvIndex)){
        case 0...2:
            return "Low level of exposure."
        case 3...5:
            return "Moderate level of exposure."
        case 6...7:
            return "High level of exposure."
        case 8...10:
            return "Very high level of exposure."
        default:
            return "Extreme level of exposure."
        }
    }

    var headerColor: UIColor {
        switch (Int(weather.uvIndex)){

        case 0...2:
            return UIColor.appColor(.greenishTeal)
        case 3...5:
            return UIColor.appColor(.wheat)
        case 6...7:
            return UIColor.appColor(.fadedOrange)
        case 8...10:
            return UIColor.appColor(.fadedOrange2)
        default:
            return UIColor.appColor(.perryWinkle)
        }
    }

    var sse: SSEValue{
        let location = UserLocation.load()!

        var altitudeModifier = (location.altitude / 1000) * 0.16
        
        let currentUV = weather.uvIndex == 0 ? 0.0 : weather.uvIndex * (1 + altitudeModifier) * environment.modifier
        if currentUV == 0 {
            return ("\(24)", "+hours")
        }
        let time = Int((Float(skinType.maximumTimeInSun) / currentUV) * Float(spf))
        if time < 60 {
            return ("\(time)", "minutes")
        }else if time >= 60, time < 120{
            return ("\(1)", "hour")
        }else if time > 1140{
            return ("\(24)", "+hours")
        }else{
            return ("\(time/60)", "hours")
        }

    }
}
