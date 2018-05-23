//
//  UIColor.swift
//  Sunblock
//
//  Created by Suthananth Arulanatham on 03.04.2018.
//  Copyright © 2018 Shortcut. All rights reserved.
//

import UIKit

enum ColorNames: String{

    case white 			= "white"
    case dirtyPurple	= "dirtyPurple"
    case lightGrey		= "lightGrey"
    case fadedOrange	= "fadedOrange"
    case fadedOrange2	= "fadedOrange2"
    case greenishTeal	= "greenishTeal"
    case aquaMarine		= "aquaMarine"
    case wheat			= "wheat"
    case perryWinkle	= "perrywinkle"
    case dark			= "dark"
    case cocoa			= "cocoa"
    case copper			= "copper"
    case sandbrown		= "sandbrown"
    case blush			= "blush"
    case lightPeach		= "lightPeach"
    case lightMustard	= "lightMustard"
}

extension UIColor{

    private static func namedColor(_ name: String) -> UIColor{
        guard let color = UIColor(named: name) else {
            fatalError("color: \(name) does not exist in bundle")
        }
        return color
    }

    @nonobjc class func appColor(_ name: ColorNames) -> UIColor{
        return namedColor(name.rawValue)
    }
}
