//
//  Weather+CoreDataClass.swift
//  Sunblock
//
//  Created by Suthananth Arulanatham on 17.05.2018.
//  Copyright © 2018 Shortcut. All rights reserved.
//
//

import Foundation
import CoreData


public class Weather: NSManagedObject {

    class func createWeather(from response: WeatherDataResponse,
                             in context: NSManagedObjectContext){
        let entity = NSEntityDescription.entity(forEntityName: "Weather", in: context)!
        let weather = Weather(entity: entity, insertInto: context)
        weather.icon = response.icon
        weather.summary = response.summary
        weather.temperature = response.temperature
        weather.time = Int64(response.time)
        weather.uvIndex = response.uvIndex
    }

}
