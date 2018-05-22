//
//  OnboardinDisclaimerSceneViewController.swift
//  Sunblock
//
//  Created by Suthananth Arulanatham on 21.05.2018.
//  Copyright © 2018 Shortcut. All rights reserved.
//

import UIKit
class OnboardingDisclaimerSceneViewController: UIViewController{
    private let segue = "disclaimerToLocation"
    @IBAction func buttonPressed(_ sender: Any) {
        if let status = OnboardingStatus.load(){
            let newStatus = OnboardingStatus(hasCompletedOnboardin: true, locationServiceGranted: status.locationServiceGranted)
            newStatus.save()

            if status.locationServiceGranted{
                dismiss(animated: true)
            }else{
                performSegue(withIdentifier: segue, sender: nil)
            }

        }
    }
}
