//
//  StoryboardIdentifiable.swift
//  Sunblock
//
//  Created by Suthananth Arulanatham on 25.04.2018.
//  Copyright © 2018 Shortcut. All rights reserved.
//

import UIKit

protocol StoryboardIdentifiable {
    static var storyboardIdentifier: String { get }
}

extension StoryboardIdentifiable where Self: UIViewController{
    static var storyboardIdentifier: String {
        return String(describing: self)
    }

    init(from storyboard: UIStoryboard.Storyboard){
        let storyboard = UIStoryboard(storyboard: storyboard)
        let controller = storyboard.instantiateViewController(withIdentifier: Self.storyboardIdentifier)

        guard let vc = controller as?  Self else {
            fatalError("Could not instantiate controller from class name \(Self.storyboardIdentifier)")
        }
        self = vc
    }
}


extension UIViewController: StoryboardIdentifiable{}
