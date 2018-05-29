//
//  SESkinSelectionView.swift
//  Sunblock
//
//  Created by Suthananth Arulanatham on 28.05.2018.
//  Copyright © 2018 Shortcut. All rights reserved.
//

import UIKit

protocol SESkinSelectionDelegate: class {
    func didSelectCurrentSkin()
}

class SESkinSelectionView: UIView, NibFileOwnerLoadable{

    @IBOutlet private var colorButtons		: [UIButton]!
    @IBOutlet private weak var selectButton	: UIButton!

    weak var delegate: SESkinSelectionDelegate?

    private var skinTypes: [SkinType] {
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

    convenience init(with view: UIView){
        let frame = view.bounds
        self.init(frame: frame)
        setupColorButtons()
    }

    func setupColorButtons(){
        for (index, button) in colorButtons.enumerated(){
            button.layer.cornerRadius	= button.frame.width * 0.5
            button.backgroundColor 		= skinTypes[index].skinColor
        }
    }

    func updateButton(at index: Int){
        // reset everything
        colorButtons.forEach {
            $0.transform = .identity
        }
        layoutIfNeeded()

        let button = colorButtons[index]
        button.transform = CGAffineTransform(scaleX: 1.6, y: 1.6)
    }

    @IBAction func selectButtonPressed(_ sender: UIButton) {
        delegate?.didSelectCurrentSkin()
    }
}
