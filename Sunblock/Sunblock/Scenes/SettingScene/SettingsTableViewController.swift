//
//  SettingsTableViewController.swift
//  Sunblock
//
//  Created by Suthananth Arulanatham on 21.08.2018.
//  Copyright © 2018 Shortcut. All rights reserved.
//

import UIKit
import MessageUI

class SettingsTableViewController: UITableViewController {

    // Segue Identifiers
	private let skinChooser = "SkinChooser"
    private let disclaimer	= "Disclaimer"
    private let about		= "AboutThisApp"
    private let onboarding	= "onboarding"

    // Private Properties
    private let emailAdress = "sunblockapp@gmail.com"

    //MARK: -IBOutlets
    @IBOutlet weak var screenReminderSwitch	: UISwitch!
    @IBOutlet weak var updateSwitch			: UISwitch!
    @IBOutlet weak var temperatureLabel		: UILabel!




    private var shouldSetReminder 	: Bool = true {
        didSet{
            print(shouldSetReminder)
            SettingsUtility.isReminderSet = shouldSetReminder
        }
    }

    private var shouldShowUpdate	: Bool = true{
        didSet{
            print(shouldShowUpdate)
            SettingsUtility.shouldShowUpdate = shouldShowUpdate
        }
    }

    private var currentUnit	: TemperatureUnit = .celcius{
        didSet{
            print(currentUnit)
            SettingsUtility.unit = currentUnit
            temperatureLabel.text = currentUnit.description
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        if SettingsUtility.justAfterUpdate{
            
            screenReminderSwitch.isOn	= true
            updateSwitch.isOn 			= true

            shouldShowUpdate 	= true
            shouldSetReminder	= true
			currentUnit			= .celcius

            SettingsUtility.justAfterUpdate = true

        }else {
            screenReminderSwitch.isOn	= SettingsUtility.isReminderSet
            updateSwitch.isOn 			= SettingsUtility.shouldShowUpdate
            temperatureLabel.text		= SettingsUtility.unit.description
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        switch indexPath.row{
        case 1: performSegue(withIdentifier: skinChooser, sender: nil)
        case 4: showUnitSelection()
        case 6: performSegue(withIdentifier: onboarding, sender: nil)
        case 7: performSegue(withIdentifier: disclaimer, sender: nil)
        case 8: sendMail()
        case 9: performSegue(withIdentifier: about, sender: nil)
            
        default: break
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if  segue.identifier ==	 onboarding,
        	let navVC = segue.destination as? UINavigationController,
            let vc = navVC.topViewController as? OnboardingSceneViewController{
            vc.fromSettings = true
        }
    }
}

//MARK: Private functions
extension SettingsTableViewController{

    private func sendMail(){
        if MFMailComposeViewController.canSendMail(){

            let mail 					= MFMailComposeViewController()
            mail.mailComposeDelegate	= self
            mail.setToRecipients([emailAdress])
            mail.setSubject("Suggestion for version \(Bundle.main.buildVersionNumber!)")

            present(mail, animated: true)
        }else{

            UIPasteboard.general.string = emailAdress
            let alertController = UIAlertController(title: "Native mail client not configured", message: "Our email address has been copied to your clipboard.\nPlease paste it in your preferred mail client and send us an 📧", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))

            present(alertController, animated: true)
        }
    }

    private func showUnitSelection(){

        let alertController = UIAlertController(title: "Select Temperature Unit", message: nil, preferredStyle: .actionSheet)

        alertController.addAction(UIAlertAction(title: "Celcius ℃", style: .default, handler: { (_) in
            self.currentUnit = .celcius
        }))

        alertController.addAction(UIAlertAction(title: "Fahrenheit ℉", style: .default, handler: { (_) in
            self.currentUnit = .fahrenheit
        }))

        present(alertController, animated: true)
    }
}

//MARK: IBActions
extension SettingsTableViewController{
    
    @IBAction private func backButtonPressed(){
        dismiss(animated: true, completion: nil)
    }

    @IBAction private func reminderSwitchTapped(_ sender: UISwitch) {
        shouldSetReminder = sender.isOn
    }

    @IBAction private func updateSwitchTapped(_ sender: UISwitch) {
        shouldShowUpdate = sender.isOn
    }
}

//MARK: MFMailComposeViewControllerDelegate

extension SettingsTableViewController: MFMailComposeViewControllerDelegate{

    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {

        controller.dismiss(animated: true)
    }
}
