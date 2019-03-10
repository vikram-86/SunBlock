//
//  ToastView.swift
//  Sunblock
//
//  Created by Vikram on 10/03/2019.
//  Copyright © 2019 Shortcut. All rights reserved.
//

import UIKit

enum SSEToastState {
    
    case autoReminderDisabled
    case notificationPermissionDenied
    case setNewTimer(String)
    case changeTimer(String)
    
    var description: String {
        switch self {
        case .autoReminderDisabled:
            return "You have disabled auto reminder. Please turn it on in settings page."
        case .notificationPermissionDenied:
            return "You have disabled notifications. Please turn it on in the settings and try again"
        case .setNewTimer(let deadline):
            return "Reminder set. I'll remind you to re-apply sunscreen at: \(deadline)"
        case .changeTimer(let deadline):
            return "New reminder set, I'll remind you to re-apply sunscreen at: \(deadline)"
        }
    }
}

class ToastView: UIView, NibFileOwnerLoadable {
    
    @IBOutlet weak var textLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadNibContent()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadNibContent()
    }
    
    convenience init(with state: SSEToastState) {
        let height  : CGFloat = 80
        let width   : CGFloat = UIScreen.main.bounds.width
        
        let frame   = CGRect(x: 0, y: 40, width: width, height: height)
        self.init(frame: frame)
        setupView(with: state)
    }
    
    func setupView(with state: SSEToastState) {
        textLabel.text = state.description
    }
}
