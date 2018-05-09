//
//  MainButton.swift
//  Sunblock
//
//  Created by Suthananth Arulanatham on 15.04.2018.
//  Copyright © 2018 Shortcut. All rights reserved.
//

import UIKit

@IBDesignable
class MainButton: UIButton {


    @IBInspectable
    var cornerRadius: CGFloat = 0 {
        didSet{
            layer.cornerRadius = cornerRadius
        }
    }

    var currentBackgroundName: ColorNames = .aquaMarine{
        didSet{
            self.backgroundColor = UIColor.appColor(currentBackgroundName)
        }
    }
}
