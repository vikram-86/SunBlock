//
//  OnboardinLocationSceneViewController.swift
//  Sunblock
//
//  Created by Suthananth Arulanatham on 21.05.2018.
//  Copyright © 2018 Shortcut. All rights reserved.
//

import UIKit

class OnboardinLocationSceneViewController: UIViewController {

    let service = LocationService.current

    @IBAction func ButtonPressed(_ sender: Any) {

        let newStatus = OnboardingStatus(hasCompletedOnboardin: true, locationServiceGranted: true)
        newStatus.save()
        service.delegate = self
        service.requestLocation()
    }
}

extension OnboardinLocationSceneViewController: LocationServiceDelegate{

    func locationServiceDidFinish(with location: UserLocation) {

    }

    func locationServiceDidFinishWithError(_ error: LocationError) {
    }

    func permissionChanged(_ permission: PermissionStatus) {
        if permission == .granted{
            let newStatus = OnboardingStatus(hasCompletedOnboardin: true, locationServiceGranted: true)
            newStatus.save()
            dismiss(animated: true)

        }else{
            AlertService.presentAlert(with: "Please enable location service in the settings app and try again") { (_) -> Void in
                DispatchQueue.main.async {
                    self.dismiss(animated: true)
                }
            }
        }
    }
}
