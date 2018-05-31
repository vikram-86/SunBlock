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
        if UIDevice.currentDevice == .unknown{
            setupForIpad(title: title, content: content)
        }else{
            setupForIphones(title: title, content: content)
        }
    }

    private func setupForIphones(title: String, content: String){
        titleLabel.text     = title
        let attributedText = NSMutableAttributedString(string: content)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 0
        paragraphStyle.lineHeightMultiple = 1.4
        attributedText.addAttribute(NSAttributedStringKey.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, attributedText.length))
        contentLabel.attributedText    = attributedText
        let fontSize: CGFloat = UIDevice.currentDevice == .iPhone5 ? 15 : 19
        contentLabel.font = UIFont.appFont(with: .archivoRegular, size: fontSize)
    }

    private func setupForIpad(title: String, content: String){
        titleLabel.text     = title
        titleLabel.font		= UIFont.appFont(with: .archivoSemiBold, size: 16)

        let attributedText 	= NSMutableAttributedString(string: content)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 0
        paragraphStyle.lineHeightMultiple = 1.4
        attributedText.addAttribute(NSAttributedStringKey.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, attributedText.length))
        contentLabel.attributedText    = attributedText
        let fontSize: CGFloat = 11
        contentLabel.font = UIFont.appFont(with: .archivoRegular, size: fontSize)
    }
}
