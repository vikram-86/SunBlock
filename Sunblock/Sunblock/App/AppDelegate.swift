//
//  AppDelegate.swift
//  Sunblock
//
//  Created by Suthananth Arulanatham on 03.04.2018.
//  Copyright © 2018 Shortcut. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    lazy var profiles : [Profile]  = {
        return loadFromPlist()
    }()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        UIApplication.shared.statusBarStyle = .lightContent

        // Setup Cell Appearance
        let colorView = UIView()
        colorView.backgroundColor = .clear
        UITableViewCell.appearance().selectedBackgroundView = colorView

        if UserDefaults.standard.bool(forKey: "shouldSkipOnboarding"){
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            window?.rootViewController = storyboard.instantiateInitialViewController()
        }
        UIApplication.shared.statusBarStyle = .default
        return true
    }

    func loadFromPlist()->[Profile]{
        if let path = Bundle.main.url(forResource: "Profiles", withExtension: "plist"),
        	let data = try? Data(contentsOf: path){
            let decoder = PropertyListDecoder()
            do{
                return try decoder.decode([Profile].self, from: data)
            }catch{
                fatalError("Profiles.plist does not exist")
            }
        }
        return []
    }
}

var appDelegate: AppDelegate{
    return (UIApplication.shared.delegate as! AppDelegate)
}

