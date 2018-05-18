//
//  Weather+CoreDataProperties.swift
//  Sunblock
//
//  Created by Suthananth Arulanatham on 17.05.2018.
//  Copyright © 2018 Shortcut. All rights reserved.
//
//

import Foundation
import CoreData


extension Weather {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Weather> {
        return NSFetchRequest<Weather>(entityName: "Weather")
    }

    @NSManaged public var time: Int64
    @NSManaged public var summary: String
    @NSManaged public var icon: String
    @NSManaged public var temperature: Float
    @NSManaged public var uvIndex: Float

}
