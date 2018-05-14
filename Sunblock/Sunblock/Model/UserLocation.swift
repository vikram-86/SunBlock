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
    let cityName	: String
    let country		: String
    let coordinate	: UserCoordinate
}
