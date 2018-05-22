//
//  UIViewController.swift
//  Sunblock
//
//  Created by Suthananth Arulanatham on 22.05.2018.
//  Copyright © 2018 Shortcut. All rights reserved.
//

import UIKit

extension UIViewController {
    func topMostViewController() -> UIViewController {
        if let navigation = self.presentedViewController as? UINavigationController {
            return navigation.visibleViewController!.topMostViewController()
        }
        if let tab = self.presentedViewController as? UITabBarController {
            if let selectedTab = tab.selectedViewController {
                return selectedTab.topMostViewController()
            }
            return tab.topMostViewController()
        }

        if self.presentedViewController == nil {
            return self
        }
        return self.presentedViewController!.topMostViewController()
    }
}

extension UIApplication {
    func topMostViewController() -> UIViewController? {
        return self.keyWindow?.rootViewController?.topMostViewController()
    }
}
