//
//  UIView.swift
//  Sunblock
//
//  Created by Suthananth Arulanatham on 28.04.2018.
//  Copyright © 2018 Shortcut. All rights reserved.
//

import UIKit

extension UIView{
    var setRoundedCorners: Bool{
        set{
            if newValue{
                self.layer.cornerRadius = self.frame.height * 0.5
            }else{
                self.layer.cornerRadius = 0
            }
        }
        get{
            return self.layer.cornerRadius == 0
        }
    }
}
