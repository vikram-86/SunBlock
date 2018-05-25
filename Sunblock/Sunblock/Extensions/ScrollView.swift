//
//  ScrollView.swift
//  Sunblock
//
//  Created by Suthananth Arulanatham on 25.05.2018.
//  Copyright © 2018 Shortcut. All rights reserved.
//

import UIKit


extension UIScrollView{

    open override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        guard let touch = touches.first else { return }

        let dict = ["touch": touch]
        NotificationCenter.default.post(name: .viewTouched, object: nil, userInfo: dict)
    }
}
