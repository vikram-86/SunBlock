//
//  UIDevice.swift
//  Sunblock
//
//  Created by Suthananth Arulanatham on 24.05.2018.
//  Copyright © 2018 Shortcut. All rights reserved.
//

import UIKit

extension UIDevice{
    enum DeviceType{
        case iPhone5
        case iPhone7
        case iPhone7Plus
        case iPhoneX
        case unknown
    }

    static var currentDevice: DeviceType{
        switch UIScreen.main.nativeBounds.height{
        case 1136:
            return .iPhone5
        case 1334:
            return .iPhone7
        case 2208:
            return .iPhone7Plus
        case 2436:
            return .iPhoneX
        default:
            return .unknown
        }
    }

    static var isIPhone5: Bool{
        return currentDevice == .iPhone5
    }
}
