//
//  SSEView.swift
//  Sunblock
//
//  Created by Suthananth Arulanatham on 20.05.2018.
//  Copyright © 2018 Shortcut. All rights reserved.
//

import UIKit

@IBDesignable class SSEView: UIView, NibFileOwnerLoadable{

    //MARK: IBOutlets
    @IBOutlet private var valueLabel	: UILabel!
    @IBOutlet private var unitLabel		: UILabel!
    @IBOutlet private var buttonView	: UIView!

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()

    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    private func setup(){
        loadNibContent()
        valueLabel.alpha	= 0
        unitLabel.alpha		= 0
        buttonView.isHidden = true
    }
}

//MARK: IBActions
extension SSEView{

    @IBAction private func startReminder(){
        print("starting reminder")
        UserNotificationService.current.scheduleNotification(with: 60)
    }

    func configure(with value: SSEValue){
        valueLabel.text = value.duration
        unitLabel.text	= value.unit

        valueLabel.alpha	= 1
        unitLabel.alpha		= 1
    }
}

