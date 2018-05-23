//
//  CoreDataStack.swift
//  Sunblock
//
//  Created by Suthananth Arulanatham on 15.05.2018.
//  Copyright © 2018 Shortcut. All rights reserved.
//

import Foundation
import CoreData


class CoreDataStack{

    static let current = CoreDataStack()
    
    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
         */
        let container = NSPersistentContainer(name: "Sunblock")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.

                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

    func clearStorage(){
        let managedObjectContext	= persistentContainer.viewContext
        let fetchRequest 			= NSFetchRequest<NSFetchRequestResult>(entityName: "Weather")
        let batchDeleteRequest		= NSBatchDeleteRequest(fetchRequest: fetchRequest)

        do{
            try managedObjectContext.execute(batchDeleteRequest)
        }catch let error as NSError{
            print("error: \(error)")
        }
    }

    func fetchFromStorage() -> [Weather]?{
        let managedObjectContext = persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<Weather>(entityName: "Weather")
        let sort = NSSortDescriptor(key: #keyPath(Weather.time), ascending: true)
        let time = Int64(Date.timeIntervalForCurrentHour)

        let predicate = NSPredicate(format: "time >= %i", time)
        fetchRequest.predicate = predicate
        fetchRequest.sortDescriptors = [sort]
        
        do{
            let weathers = try managedObjectContext.fetch(fetchRequest)

            return weathers
        }catch let error {
            print(error)
            return nil
        }
    }

    @discardableResult func createWeathers(from response: WeatherResponse) -> [Weather]{
        let context = persistentContainer.viewContext
        var weathers = [Weather]()
        response.hourly.data.forEach {
            let weather = Weather.createWeather(from: $0, in: context)
            weathers.append(weather)
        }

        saveContext()
        return weathers
    }
}
