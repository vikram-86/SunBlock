//
//  Profile.swift
//  Sunblock
//
//  Created by Suthananth Arulanatham on 06.05.2018.
//  Copyright © 2018 Shortcut. All rights reserved.
//

import UIKit

struct Profile: Codable{

    let name						: String
    let description					: String
    private let profileImageName	: String

    var profileImage: UIImage{
        guard
        	let image = UIImage(named: profileImageName)
        else{
            fatalError("Could not load image for user: \(name)")
        }
        return image
    }
}
