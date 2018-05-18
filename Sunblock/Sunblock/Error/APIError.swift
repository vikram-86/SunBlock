//
//  APIError.swift
//  Sunblock
//
//  Created by Suthananth Arulanatham on 14.05.2018.
//  Copyright © 2018 Shortcut. All rights reserved.
//

import Foundation

enum APIError: Error{
    case requestFailed
    case jsonConversionFailed
    case invalidData
    case responseUnsuccessful
    case jsonParsingFailure


    var localizedDescription: String{
        switch self {

        case .requestFailed			: return "Request Failed"
        case .invalidData			: return "Invalid Data"
        case .responseUnsuccessful	: return "Response Unsuccessful"
        case .jsonParsingFailure	: return "JSON Parsing Failure"
        case .jsonConversionFailed	: return "JSON Conversion Failure"
        }
    }
}
