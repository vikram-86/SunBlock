//
//  OnboardingStatus.swift
//  Sunblock
//
//  Created by Suthananth Arulanatham on 21.05.2018.
//  Copyright © 2018 Shortcut. All rights reserved.
//

import Foundation

struct OnboardingStatus: Codable{
    struct Keys{
        static let oboardinStatus = "OnboardingStatus"
    }

    let hasCompletedOnboardin	: Bool
    let locationServiceGranted	: Bool

    func save() -> Bool{
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(self){
            UserDefaults.standard.set(encoded, forKey: Keys.oboardinStatus)
            return true
        }
        return false
    }

    static func load() -> OnboardingStatus? {
        let decoder = JSONDecoder()
        if let data = UserDefaults.standard.data(forKey: Keys.oboardinStatus){
            return try? decoder.decode(OnboardingStatus.self, from: data)
        }
        return nil 
    }
}
