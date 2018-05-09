//
//  Reusable.swift
//  Sunblock
//
//  Created by Suthananth Arulanatham on 24.04.2018.
//  Copyright © 2018 Shortcut. All rights reserved.
//

import Foundation

typealias NibReusable = Reusable & NibLoadable

protocol Reusable: class {
    static var reuseIdentifier: String { get }
}

extension Reusable{
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
