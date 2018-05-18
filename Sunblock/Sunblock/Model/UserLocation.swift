//
//  UserLocation.swift
//  Sunblock
//
//  Created by Suthananth Arulanatham on 14.05.2018.
//  Copyright © 2018 Shortcut. All rights reserved.
//

import Foundation

typealias UserCoordinate = (latitude: Float, longitude: Float)

struct UserLocation{
    struct Keys{
        static let cityName 	= "cityName"
        static let country 		= "country"
        static let latitude 	= "latitude"
        static let longitude	= "longitude"
        static let location		= "location"
        static let altitude		= "altitude"
    }

    let cityName	: String
    let country		: String
    let coordinate	: UserCoordinate
    let altitude	: Float

    var coordinateAsString: String {
        return "\(coordinate.latitude),\(coordinate.longitude)"
    }


    func save(){
        let dictionary: [String: Any] = [
            Keys.cityName		: cityName,
            Keys.country 		: country,
            Keys.latitude		: coordinate.latitude,
            Keys.longitude		: coordinate.longitude,
            Keys.altitude		: altitude
        ]

        UserDefaults.standard.set(dictionary, forKey: Keys.location)
    }

    static func load() -> UserLocation? {
        guard
            let locationDict	= UserDefaults.standard.object(forKey: Keys.location) as? [String: Any],
        	let cityName		= locationDict[Keys.cityName] as? String,
        	let country 		= locationDict[Keys.country] as? String,
        	let latitude		= locationDict[Keys.latitude] as? Float,
        	let longitude		= locationDict[Keys.longitude] as? Float,
            let altitude		= locationDict[Keys.altitude] as? Float
        else{ return nil }

        return UserLocation(cityName: cityName, country: country, coordinate: (latitude: latitude,
                                                                               longitude: longitude), altitude: altitude)
    }
}

extension UserLocation: Equatable{
    
    static func == (lhs: UserLocation, rhs: UserLocation) -> Bool {
        return lhs.cityName == rhs.cityName && lhs.country == rhs.country
    }
}
