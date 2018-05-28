//
//  OnboardingHeaderView.swift
//  Sunblock
//
//  Created by Suthananth Arulanatham on 28.05.2018.
//  Copyright © 2018 Shortcut. All rights reserved.
//

import UIKit

class OnboardingHeaderView: UIView, NibFileOwnerLoadable{

    @IBOutlet private weak var imageView	: UIImageView!

    override init(frame: CGRect) {
        super.init(frame: frame)
        loadNibContent()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadNibContent()
    }

    convenience init(with image: UIImage, and x: CGFloat){
        let frame = CGRect(x: x, y: 0, width: UIScreen.main.bounds.width, height: 667)
        self.init(frame: frame)
        loadNibContent()
        self.imageView.image = image
    }
}
