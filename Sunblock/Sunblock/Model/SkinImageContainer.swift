//
//  SkinImageContainer.swift
//  Sunblock
//
//  Created by Suthananth Arulanatham on 24.04.2018.
//  Copyright © 2018 Shortcut. All rights reserved.
//

import UIKit

struct SkinImageContainer{
    private let maleImageName	: String
    private let femaleImageName	:	String

    init(maleName: String, femaleName: String){
        maleImageName 	= maleName
        femaleImageName	= femaleName
    }

    var maleImage: UIImage {
        return getImage(for: maleImageName)
    }

    var femaleImage: UIImage {
        return getImage(for: femaleImageName)
    }

    private func getImage(for name: String)-> UIImage {
        guard let image = UIImage(named: name) else {
            fatalError("Required Image \(name) is not present")
        }
        return image
    }
}
