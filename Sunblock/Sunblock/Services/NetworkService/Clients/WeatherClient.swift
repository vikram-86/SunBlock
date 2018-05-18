//
//  WeatherClient.swift
//  Sunblock
//
//  Created by Suthananth Arulanatham on 14.05.2018.
//  Copyright © 2018 Shortcut. All rights reserved.
//

import Foundation

class WeatherClient: APIClient{
    let session	: URLSession

    init(configuration: URLSessionConfiguration){
        self.session = URLSession(configuration: configuration)
    }

    convenience init(){
        self.init(configuration: .default)
    }

    func getFeed(from weatherFeedType: WeatherFeed,
                 completion: @escaping(Result<WeatherResponse?, APIError>)->Void){

        fetch(with: weatherFeedType.request, validCodes: weatherFeedType.validCodes, decode: { (json) -> WeatherResponse? in
            guard let weatherFeedResult = json as? WeatherResponse	 else { return nil }
            return weatherFeedResult
        }, completion: completion)
    }
}
