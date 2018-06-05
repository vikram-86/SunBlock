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

    @IBOutlet weak var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.isScrollEnabled = UIDevice.currentDevice == .unknown
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UIApplication.shared.statusBarStyle = .default
    }
}

extension SettingsSceneViewController{

    @IBAction private func close(){
        dismiss(animated: true)
    }


    @IBAction private func composeMail(){

        if MFMailComposeViewController.canSendMail(){
            let mailVC = configureMailComposeViewController()
            present(mailVC, animated: true)
        }else{
            // present error alert
            AlertService.presentAlert(with: "Please send an email to : sunblockapp@gmail.com", title: "Native mail client not configured")
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
