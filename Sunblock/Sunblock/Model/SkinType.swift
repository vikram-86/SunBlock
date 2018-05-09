//
//  SkinType.swift
//  Sunblock
//
//  Created by Suthananth Arulanatham on 24.04.2018.
//  Copyright © 2018 Shortcut. All rights reserved.
//

import Foundation

enum SkinType: String {

    case type1	= "type_1"
    case type2	= "type_2"
    case type3	= "type_3"
    case type4	= "type_4"
    case type5	= "type_5"
    case type6	= "type_6"

    var container: SkinImageContainer{

        let maleName 	= "Male_\(self.rawValue)"
        let femaleName	= "Female_\(self.rawValue)"
        return SkinImageContainer(maleName: maleName, femaleName: femaleName)
    }

    static var allSkinTypes: [SkinType]{
        return [
            type1,
            type2,
            type3,
            type4,
            type5,
            type6
        ]
    }
}
