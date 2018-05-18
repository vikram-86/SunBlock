//
//  Endpoint.swift
//  Sunblock
//
//  Created by Suthananth Arulanatham on 14.05.2018.
//  Copyright © 2018 Shortcut. All rights reserved.
//

import Foundation

protocol Endpoint{
    
    var base		: String { get }
    var path		: String { get }
    var validCodes	: [Int] { get }
    var queryItems	: [URLQueryItem] { get }
}

extension Endpoint{

    var apiKey: String {
        return "4789128198e1c1afb1ba895f0954e0e2"
    }

    var urlComponents: URLComponents{
        var components = URLComponents(string: base)!
        components.path = path
        components.queryItems = queryItems
        return components
    }

    var request: URLRequest{	
        let url = urlComponents.url!
        return URLRequest(url: url)
    }
}

