//
//  NotificationAlertView.swift
//  Sunblock
//
//  Created by Vikram on 10/03/2019.
//  Copyright © 2019 Shortcut. All rights reserved.
//

import UIKit

protocol NotificationAlertViewDelegate: class {
    func notificationDidAccept()
    func notificationDidDecline()
}

class NotificationAlertView: UIView, NibFileOwnerLoadable {
    
    @IBOutlet weak var alertView    : UIView!
    
    
    weak var delegate: NotificationAlertViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadNibContent()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadNibContent()
    }
    
    convenience init() {
        let frame = UIScreen.main.bounds
        self.init(frame: frame)
        initialSetup()
    }
    
    private func initialSetup() {
        backgroundColor                 = .clear
        alertView.layer.cornerRadius    = 10
        alertView.clipsToBounds         = true
        alertView.transform             = CGAffineTransform(scaleX: 0.001, y: 0.001)
    }
    
    func animateAlert() {
        UIView.animate(withDuration: 0.33) {
            self.backgroundColor = UIColor.black.withAlphaComponent(0.45)
            self.alertView.transform = .identity
        }
    }
    
    func dismissAlert(didAccept: Bool) {
        UIView.animate(withDuration: 0.33, animations: {
            self.backgroundColor = .clear
            self.alertView.transform = CGAffineTransform(scaleX: 0.001, y: 0.001)
        }) { (_) in
            if didAccept {
                self.delegate?.notificationDidAccept()
            } else {
                self.delegate?.notificationDidDecline()
            }
            self.removeFromSuperview()
        }
    }
    
    @IBAction func acceptButtonPressed(_ sender: Any) {
        dismissAlert(didAccept: true)
    }
    @IBAction func declineButtonPressed(_ sender: Any) {
        dismissAlert(didAccept: false)
    }
}
