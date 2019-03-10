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
    @IBOutlet weak var buttonImageview	: UIImageView!
    @IBOutlet weak var button			: UIButton!
    @IBOutlet weak var buttonTitle		: UILabel!

    var sseValue: SSEValue?

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
        setupButton()

        let device = UIDevice.currentDevice
        if device == .iPhone5 || device == .unknown{
            let font = UIFont.appFont(with: .nevis, size: 40)
            valueLabel.font = font
        }
    }

    private func setupButton(){
        UserNotificationService.current.hasPendingNotificationRequests { (result) in
            DispatchQueue.main.async {
                if result{
                    self.buttonImageview.image = #imageLiteral(resourceName: "icDashboardActive")
                    self.button.isUserInteractionEnabled = true
                    self.buttonTitle.text	= "Reset reminder"

                }else{
                    self.buttonImageview.image = #imageLiteral(resourceName: "stopWatch")
                    self.button.isUserInteractionEnabled = true
                    self.buttonTitle.text = "Start reminder"
                }
            }
        }
    }
}

//MARK: IBActions
extension SSEView{

    @IBAction private func startReminder(){
        print("starting reminder")
        guard let minutes = sseValue?.duration else { return }
        let timeInterval: TimeInterval = Double(minutes) * 60
        UserNotificationService.current.scheduleNotification(with: timeInterval)
        self.buttonImageview.image = #imageLiteral(resourceName: "icDashboardActive")
        self.buttonTitle.text = "Reset reminder"
    }

//    func configure(with value: SSEValue){
//        valueLabel.text = value.duration
//        unitLabel.text    = value.unit
//
//        self.sseValue = value
//
//        valueLabel.alpha    = 1
//        unitLabel.alpha        = 1
//
//        if value.minutes >= (60 * 24) {
//            buttonView.isHidden = false
//            UserNotificationService.current.removeAllPendingRequests()
//            buttonTitle.text    = "Start reminder"
//            buttonImageview.image = #imageLiteral(resourceName: "stopWatch")
//        }else{
//            buttonView.isHidden = true
//        }
//        setupButton()
//    }
}


