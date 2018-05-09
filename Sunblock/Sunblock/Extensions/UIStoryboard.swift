//
//  UIStoryboard.swift
//  Sunblock
//
//  Created by Suthananth Arulanatham on 25.04.2018.
//  Copyright © 2018 Shortcut. All rights reserved.
//

import UIKit

extension UIStoryboard{
    enum Storyboard: String {
        case main
        
        var fileName: String {
            return rawValue.capitalized
        }
    }

    convenience init(storyboard: Storyboard, bundle: Bundle? = nil ){
        self.init(name: storyboard.fileName, bundle: bundle)
    }

    func instantiateViewController<T: StoryboardIdentifiable>() -> T{
        guard
            let viewController = self.instantiateViewController(withIdentifier: T.storyboardIdentifier) as? T
            else {
                fatalError("Could'nt instantiate controller with identifier \(T.storyboardIdentifier)")
        }
        return viewController
    }
}
