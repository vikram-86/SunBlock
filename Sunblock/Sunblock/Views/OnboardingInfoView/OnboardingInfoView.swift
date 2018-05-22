//
//  OnboardingInfoView.swift
//  Sunblock
//
//  Created by Suthananth Arulanatham on 20.05.2018.
//  Copyright © 2018 Shortcut. All rights reserved.
//

import UIKit

class OnboardingInfoView: UIView, NibFileOwnerLoadable{

    @IBOutlet private weak var titleLabel	: UILabel!
    @IBOutlet private weak var contentLabel	: UILabel!


    override init(frame: CGRect) {
        super.init(frame: frame)
        loadNibContent()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadNibContent()
    }

    convenience init(x: CGFloat, height: CGFloat) {

        let frame = CGRect(x: x, y: 0, width: UIScreen.main.bounds.width, height: height)
        self.init(frame: frame)
    }

    func setupView(title: String, content: String){
        titleLabel.text 	= title
        contentLabel.text	= content
    }
}
