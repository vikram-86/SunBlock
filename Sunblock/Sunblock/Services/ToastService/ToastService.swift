//
//  ToastService.swift
//  Sunblock
//
//  Created by Vikram on 10/03/2019.
//  Copyright © 2019 Shortcut. All rights reserved.
//

import UIKit

class ToastService {
    static let current = ToastService()
    
    private(set) var isAnimating = false
    
    
    func addToast(with state: SSEToastState) {
        guard !isAnimating else { return }
        
        let toastView   = ToastView(with: state)
        let window      = UIApplication.shared.keyWindow!
        
        window.addSubview(toastView)
        toastView.transform = CGAffineTransform(translationX: 0, y: -150)
        
        isAnimating = true
        UIView.animate(withDuration: 0.33, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.5, options: .curveEaseInOut, animations: {
            toastView.transform = .identity
        }) { (_) in
            UIView.animate(withDuration: 0.33, delay: 4, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.5, options: .curveEaseInOut, animations: {
                toastView.transform = CGAffineTransform(translationX: 0, y: -150)
            }, completion: { (_) in
                toastView.removeFromSuperview()
                self.isAnimating = false
            })
        }
    }
}
