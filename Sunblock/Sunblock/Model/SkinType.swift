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

    var maximumTimeInSun: Int {
        switch self {
        case .type1: return 67
        case .type2: return 100
        case .type3: return 200
        case .type4: return 300
        case .type5: return 400
        case .type6: return 500
        }
    }

    var skinDescription: String {
        switch self {
        case .type1:
            return "Never tans, always burns easily, skin particularly light, freckles, redish hair. (All babies and children.)"
        case .type2:
            return "Freckles rare, tans slightly, high inclination to sunburn"
        case .type3:
            return "Skin light/light brown, no freckles, good tanning ability, very low inclination to sunburn."
        case .type4:
            return "Skin light-brown to olive, no freckles, very good tanning ability, very low inclination to sunburn"
        case .type5:
            return "Olive skin  in color, sun insensitive skin, very low inclination to sunburn"
        case .type6:
            return "Skin deeply pigmented, sun insensitive skin, never burns"
        }
    }

    var geneticOrigin: String {
        switch self{
        case .type1:
            return "Scandinavian, Celtic"
        case .type2:
            return "Caucasians"
        case .type3:
            return "Central Europe"
        case .type4:
            return "South Mediteranean, South American"
        case .type5:
            return "Middle Eastern, Asia, some Hispanics and Afro-American"
        case .type6:
            return "African, Afro-American"
        }
    }
}
