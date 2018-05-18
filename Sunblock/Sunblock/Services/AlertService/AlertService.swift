//
//  AlertService.swift
//  Sunblock
//
//  Created by Suthananth Arulanatham on 14.05.2018.
//  Copyright © 2018 Shortcut. All rights reserved.
//

import UIKit

class AlertService{

    class func presentAlert(with text: String){
        DispatchQueue.main.async {
            guard let vc = appDelegate.window?.rootViewController else {
                return
            }
            let alertController = UIAlertController(title: "Ops! Something went wrong", message: text, preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))

            vc.present(alertController, animated: true)
        }
    }
}
