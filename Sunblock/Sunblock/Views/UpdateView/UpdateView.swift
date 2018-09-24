//
//  UpdateView.swift
//  Sunblock
//
//  Created by Suthananth Arulanatham on 06.09.2018.
//  Copyright © 2018 Shortcut. All rights reserved.
//

import UIKit

class UpdateView: UIView, NibFileOwnerLoadable{

    override init(frame: CGRect) {
        super.init(frame: frame)
        loadNibContent()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadNibContent()
    }
}
