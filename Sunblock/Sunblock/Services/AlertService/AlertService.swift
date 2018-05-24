//
//  AlertService.swift
//  Sunblock
//
//  Created by Suthananth Arulanatham on 14.05.2018.
//  Copyright © 2018 Shortcut. All rights reserved.
//

import UIKit

class AlertService{

    class func presentAlert(with text: String,title: String? = nil, handler: ((UIAlertAction) -> Void)? = nil ){
        DispatchQueue.main.async {
            guard let vc = appDelegate.window?.rootViewController?.topMostViewController() else {
                return
            }
			let title = title ?? "Ops! Something went wrong"
            let alertController = UIAlertController(title: title, message: text, preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: handler))

            vc.present(alertController, animated: true)
        }
    }
}
