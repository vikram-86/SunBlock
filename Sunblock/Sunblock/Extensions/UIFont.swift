//
//  UIFont.swift
//  Sunblock
//
//  Created by Suthananth Arulanatham on 20.05.2018.
//  Copyright © 2018 Shortcut. All rights reserved.
//

import UIKit

enum Fontname: String {
    case archivoBold 			= "Archivo-Bold"
    case archivoBoldItalic 		= "Archivo-BoldItalic"
    case archivoItalic 			= "Archivo-Italic"
    case archivoMedium 			= "Archivo-Medium"
    case archivoMediumItalic 	= "Archivo-MediumItalic"
    case archivoRegular 		= "Archivo-Regular"
    case archivoSemiBold 		= "Archivo-SemiBold"
    case archivoSemiBoldItalic	= "Archivo-SemiBoldItalic"
    case nevis					= "nevis"
}

extension UIFont{
    class func appFont(with name: Fontname, size: CGFloat ) -> UIFont {
        guard let font = UIFont(name: name.rawValue, size: size) else {
            fatalError("\(name.rawValue) could not be loaded!")
        }
        return font
    }
}
