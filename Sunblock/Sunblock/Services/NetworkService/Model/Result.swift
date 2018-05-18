//
//  Result.swift
//  Sunblock
//
//  Created by Suthananth Arulanatham on 14.05.2018.
//  Copyright © 2018 Shortcut. All rights reserved.
//

import Foundation

enum Result<T,U> where U: Error {
    case success(T)
    case failure(U)
}
