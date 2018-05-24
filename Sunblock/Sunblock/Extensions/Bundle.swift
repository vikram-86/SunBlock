//
//  Bundle.swift
//  Sunblock
//
//  Created by Suthananth Arulanatham on 24.05.2018.
//  Copyright © 2018 Shortcut. All rights reserved.
//

import UIKit

extension Bundle{

    var releaseVersionNumber: String? {
        return infoDictionary?["CFBundleShortVersionString"] as? String
    }

    var buildVersionNumber: String?{
        return infoDictionary?["CFBundleVersion"] as? String
    }
}
