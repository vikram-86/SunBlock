//
//  DisclaimerSceneViewController.swift
//  Sunblock
//
//  Created by Suthananth Arulanatham on 02.05.2018.
//  Copyright © 2018 Shortcut. All rights reserved.
//

import UIKit

class DisclaimerSceneViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

}

extension DisclaimerSceneViewController{
    @IBAction private func back(){
        navigationController?.popViewController(animated: true)
    }
}
