//
//  AboutSceneViewController.swift
//  Sunblock
//
//  Created by Suthananth Arulanatham on 02.05.2018.
//  Copyright © 2018 Shortcut. All rights reserved.
//

import UIKit

class AboutSceneViewController: UIViewController {

    @IBOutlet weak var profileView1: ProfileView!
    @IBOutlet weak var profileView2: ProfileView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupProfileViews()
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
