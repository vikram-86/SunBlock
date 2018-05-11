//
//  MainSceneViewController.swift
//  Sunblock
//
//  Created by Suthananth Arulanatham on 03.04.2018.
//  Copyright © 2018 Shortcut. All rights reserved.
//

import UIKit

class MainSceneViewController: UIViewController {

    // Private
    private let spfSegue	= "spfSegue"
    @IBOutlet weak var spfStackView: UIStackView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = UIColor.appColor(.perryWinkle)

        // setting up touch gesture for spf
        let gesture = UITapGestureRecognizer(target: self, action: #selector(selectSunscreen))
        spfStackView.addGestureRecognizer(gesture)
    }
}

extension MainSceneViewController{

    @objc private func selectSunscreen(){
        performSegue(withIdentifier: spfSegue, sender: nil)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? SPFSelectorSceneViewController{
            vc.delegate = self

        }
    }
}

extension MainSceneViewController: SPFSelectorSceneDelegate{
    func sceneSelected(spf: Int) {
        print(spf)
    }
}
