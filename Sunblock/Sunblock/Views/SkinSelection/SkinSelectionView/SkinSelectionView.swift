//
//  SkinSelectionView.swift
//  Sunblock
//
//  Created by Suthananth Arulanatham on 29.05.2018.
//  Copyright © 2018 Shortcut. All rights reserved.
//

import UIKit

protocol SkinSelectionDelegate: class {
    func didChangeSkin(at index: Int)
    func didSelectSkin()
}

class SkinSelectionView: UIView, NibFileOwnerLoadable{

    @IBOutlet private var buttonBackgroundViews : [UIView]!
    weak var delegate: SkinSelectionDelegate?

    private var skinTypes : [SkinType]{
        return SkinType.allSkinTypes
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        loadNibContent()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadNibContent()
    }

    func setupButtonBackground(){
        for(index, view) in buttonBackgroundViews.enumerated(){
            view.layer.cornerRadius	= view.frame.width * 0.5
            view.backgroundColor 	= skinTypes[index].skinColor
        }
        self.layoutIfNeeded()
    }

    func updateButtonView(at index: Int){
        buttonBackgroundViews.forEach {
            $0.transform = .identity
        }
        let button = buttonBackgroundViews[index]
        button.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
    }

    @IBAction func buttonPressed(_ sender: UIButton) {
        delegate?.didChangeSkin(at: sender.tag)
    }

    @IBAction func selectButtonPressed(_ sender: UIButton) {
        delegate?.didSelectSkin()
    }
}
