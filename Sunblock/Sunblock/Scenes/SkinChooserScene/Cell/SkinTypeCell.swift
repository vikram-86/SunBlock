//
//  SkinTypeCell.swift
//  Sunblock
//
//  Created by Suthananth Arulanatham on 15.04.2018.
//  Copyright © 2018 Shortcut. All rights reserved.
//

import UIKit

class SkinTypeCell: UICollectionViewCell, NibReusable{

    static let identifier = "SkinTypeCell"
    //MAKR: - IBOutlets

    @IBOutlet weak var femaleImageView	: UIImageView!
    @IBOutlet weak var maleImageView	: UIImageView!

    func configureCell(with skinType: SkinType){
        self.femaleImageView.image	= skinType.container.femaleImage
        self.maleImageView.image	= skinType.container.maleImage
    }
}
