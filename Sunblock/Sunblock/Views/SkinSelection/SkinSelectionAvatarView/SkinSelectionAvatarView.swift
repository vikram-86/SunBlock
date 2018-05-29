//
//  SkinSelectionAvatarView.swift
//  Sunblock
//
//  Created by Suthananth Arulanatham on 28.05.2018.
//  Copyright © 2018 Shortcut. All rights reserved.
//

import UIKit

class SkinSelectionAvatarView: UIView, NibFileOwnerLoadable{

    @IBOutlet weak var femaleImageView	: UIImageView!
    @IBOutlet weak var maleImageView	: UIImageView!

    override init(frame: CGRect) {
        super.init(frame: frame)
        loadNibContent()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadNibContent()
    }

    convenience init(with view: UIView, skinType: SkinType){
        self.init(frame: view.bounds)


    }

    func updateImages(with skinType: SkinType){
        femaleImageView.image    = skinType.container.femaleImage
        maleImageView.image     = skinType.container.maleImage
    }
}
