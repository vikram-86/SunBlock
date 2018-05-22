//
//  LocationError.swift
//  Sunblock
//
//  Created by Suthananth Arulanatham on 14.05.2018.
//  Copyright © 2018 Shortcut. All rights reserved.
//

import Foundation
enum LocationError: Error{
    case	permissionDenied
    case	permissionDisabled
    case	notDetermined(String)
    case	permissionGranted
}

extension LocationError: LocalizedError{

    var errorDescription: String?{
        switch self{
        case .permissionDenied:
            return "You have disabled location permission, please enable permission in the Settings app"
        case .permissionDisabled:
            return "You have disbaled location services for this device, please enable it in the Settings app"
        case .notDetermined(let errorString):
            return errorString
        case .permissionGranted:
            return ""
        }
    }
}
