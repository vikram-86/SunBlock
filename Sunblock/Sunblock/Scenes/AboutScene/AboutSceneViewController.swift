//
//  AboutSceneViewController.swift
//  Sunblock
//
//  Created by Suthananth Arulanatham on 02.05.2018.
//  Copyright © 2018 Shortcut. All rights reserved.
//

import UIKit
import SafariServices

class AboutSceneViewController: UIViewController {

    @IBOutlet weak var profileView1: ProfileView!
    @IBOutlet weak var profileView2: ProfileView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupProfileViews()
        profileView1.delegate = self
        profileView2.delegate = self
    }

    @IBAction func launchWebsite(_ sender: UIButton) {
        guard let urlString = sender.currentTitle,
            let url = URL(string: urlString) else {
                return
        }

        let vc = SFSafariViewController(url: url, configuration: SFSafariViewController.Configuration())
        present(vc, animated: true)
    }

}

extension AboutSceneViewController{
    private func setupProfileViews(){
        let profiles = appDelegate.profiles
        profileView1.configure(with: profiles[1])
        profileView2.configure(with: profiles[0])
    }
}


extension AboutSceneViewController{

    @IBAction private func back(){
        navigationController?.popViewController(animated: true)
    }
}

extension AboutSceneViewController: ProfileViewDelegate{
    func view(didSelectURL url: URL) {
        let vc = SFSafariViewController(url: url, configuration: SFSafariViewController.Configuration())
        present(vc, animated: true)
    }
}
