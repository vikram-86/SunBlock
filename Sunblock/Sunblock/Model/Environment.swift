//
//  Environment.swift
//  Sunblock
//
//  Created by Suthananth Arulanatham on 18.05.2018.
//  Copyright © 2018 Shortcut. All rights reserved.
//

import Foundation
enum Environment: Int{

    struct Keys{
        static let environment = "environment"
    }

    case mountain
    case city
    case water

    init(value: Int){
        switch value{
        case 0: self = .city
        case 1: self = .mountain
        case 2: self = .water
        default: self = .city
        }
    }

    var modifier: Float {
        switch self{
        case .city		: return 1
        case .mountain	: return 1.85
        case .water		: return 1.5
        }
    }

    func save(){
        UserDefaults.standard.set(rawValue, forKey: Keys.environment)
    }

    static func load() -> Environment {
        let type = UserDefaults.standard.integer(forKey: Keys.environment)

        switch type{
        case 0: return .city
        case 1: return .mountain
        case 2: return .water
        default: return .city
        }
    }
}
