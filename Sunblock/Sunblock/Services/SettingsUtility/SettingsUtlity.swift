//
//  SettingsUtlity.swift
//  Sunblock
//
//  Created by Suthananth Arulanatham on 21.08.2018.
//  Copyright © 2018 Shortcut. All rights reserved.
//

import Foundation

struct SettingsUtility{

    private struct Keys{
        static let temperatureKey 	= "temperature"
        static let reminderKey		= "reminder"
        static let updateKey		= "update"
        static let versionKey		= Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "undefined"
    }

    static var unit : TemperatureUnit{
        set{
            UserDefaults.standard.set(newValue.intValue, forKey: Keys.temperatureKey)
        }
        get{
            let intValue = UserDefaults.standard.integer(forKey: Keys.temperatureKey)
            return TemperatureUnit(value: intValue)
        }
    }

    static var isReminderSet : Bool {
        set{
            UserDefaults.standard.set(newValue, forKey: Keys.reminderKey)
        }
        get{
            return UserDefaults.standard.bool(forKey: Keys.reminderKey)
        }
    }

    static var shouldShowUpdate: Bool {
        set{
            UserDefaults.standard.set(newValue, forKey: Keys.updateKey)
        }
        get{
            return UserDefaults.standard.bool(forKey: Keys.updateKey)
        }
    }

    static var justAfterUpdate : Bool {
        set {
            UserDefaults.standard.set(!newValue, forKey: Keys.versionKey)
        }
        get{
            return !UserDefaults.standard.bool(forKey: Keys.versionKey)
        }
    }
}
