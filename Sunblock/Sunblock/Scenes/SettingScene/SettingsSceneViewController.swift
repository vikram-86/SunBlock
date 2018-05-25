//
//  SettingsSceneViewController.swift
//  Sunblock
//
//  Created by Suthananth Arulanatham on 02.05.2018.
//  Copyright © 2018 Shortcut. All rights reserved.
//

import UIKit
import MessageUI

class SettingsSceneViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension SettingsSceneViewController{

    @IBAction private func close(){
        dismiss(animated: true)
    }


    @IBAction private func composeMail(){
        let mailVC = configureMailComposeViewController()
        if MFMailComposeViewController.canSendMail(){
            present(mailVC, animated: true)
        }else{
            // present error alert
            AlertService.presentAlert(with: "No mail Configured", title: "You have not configured a mail client")
        }
    }

    private func configureMailComposeViewController() -> MFMailComposeViewController{
        let mailComposerVC = MFMailComposeViewController()
        mailComposerVC.mailComposeDelegate = self

        mailComposerVC.setToRecipients(["sunblockapp@gmail.com"])
        mailComposerVC.setSubject("Suggestion for version \(Bundle.main.buildVersionNumber!)")
        return mailComposerVC
    }
}

extension SettingsSceneViewController: MFMailComposeViewControllerDelegate, UINavigationControllerDelegate{
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
    }
}
