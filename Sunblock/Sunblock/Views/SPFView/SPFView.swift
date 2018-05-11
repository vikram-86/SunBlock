//
//  SPFView.swift
//  Sunblock
//
//  Created by Suthananth Arulanatham on 11.05.2018.
//  Copyright © 2018 Shortcut. All rights reserved.
//

import UIKit

class SPFView: UIView, NibFileOwnerLoadable {

    @IBOutlet weak var valueLabel: UILabel!
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadNibContent()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadNibContent()
    }

    func set(value: Int){
        valueLabel.text = "\(value)"
    }
}
