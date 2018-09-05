//
//  SSEValue.swift
//  Sunblock
//
//  Created by Suthananth Arulanatham on 26.08.2018.
//  Copyright © 2018 Shortcut. All rights reserved.
//

import Foundation

struct SSEValue: Codable{

    let duration		: Int
    let currentSPF		: Int
    let creationDate	: Date

    init(duration: Int, currentSPF: Int) {
        self.duration 	= duration
        self.currentSPF	= currentSPF
        creationDate = Date()
    }

    var spfDescription : String {
        let safeDate = Date.add(minutes: timeRemaining)
        return "You are protected until \(safeDate.hourClock)"
    }

    var unit : String {
        if timeRemaining < 60 {
            return "\(timeRemaining) minutes"
        }else if timeRemaining == 60 {
            return "1 hour"
        }else if timeRemaining > 60, timeRemaining < 120 {
            let minutes = timeRemaining % 60
            return "1h and \(minutes)min"
        }else{
            return "2 hours"
        }
    }

    var backgroundColorName: ColorNames {
        switch timeRemaining{
        case 0...24		: return ColorNames.perryWinkle
        case 25...48	: return ColorNames.fadedOrange2
        case 49...72	: return ColorNames.fadedOrange
        case 73...96	: return ColorNames.wheat
        default: return ColorNames.greenishTeal
        }
    }

    var timeRemaining: Int {
        // return 0
        let elapsedTime = Date().timeIntervalSince(creationDate)
        return duration - Int(elapsedTime / 60000)
    }

    func save(){
        PersistanceService.store(self, to: .documents, as: "sseValue")
    }

    static func load() -> SSEValue?{
        if PersistanceService.fileExists("sseValue", in: .documents){
            let value =  PersistanceService.retrieve("sseValue",
                                                    from: .documents,
                                                    as: SSEValue.self)
            if value.creationDate.hasExceeded(duration: value.duration){
                return nil
            }
            return value
        }
        
        return nil
    }
}
