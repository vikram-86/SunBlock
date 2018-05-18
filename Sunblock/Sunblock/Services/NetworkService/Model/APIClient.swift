//
//  APIClient.swift
//  Sunblock
//
//  Created by Suthananth Arulanatham on 14.05.2018.
//  Copyright © 2018 Shortcut. All rights reserved.
//

import Foundation

protocol APIClient{

    var session: URLSession { get }

    func fetch<T: Decodable>(with request: URLRequest,
                             validCodes: [Int],
                             decode:@escaping (Decodable) -> T?,
                             completion: @escaping(Result<T,APIError>)->Void)
}

extension APIClient{

    typealias JSONTaskCompletionHandler = (Decodable?, APIError?) -> Void
    private func decodingTask<T: Decodable>(with request: URLRequest,
                                            decodingType: T.Type,
                                            validCodes:[Int],
                                            completionHandler completion: @escaping JSONTaskCompletionHandler) -> URLSessionTask{
        let task = session.dataTask(with: request) { (data, response, error) in
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(nil, .requestFailed)
                return
            }

            if validCodes.contains(httpResponse.statusCode) {
                if let data = data{
                    do{
                        let decoder = JSONDecoder()
                        let genericModel = try decoder.decode(decodingType, from: data)
                        completion(genericModel, nil)
                    }catch{
                        completion(nil, .jsonConversionFailed)
                    }
                }else{
                    completion(nil, .invalidData)
                }
            }else{
                completion(nil, .responseUnsuccessful)
            }
        }
        return task
    }

    func fetch<T: Decodable>(with request: URLRequest,
                             validCodes: [Int],
                             decode: @escaping (Decodable)->T?,
                             completion: @escaping(Result<T,APIError>)->Void){

        let task = decodingTask(with: request, decodingType: T.self, validCodes: validCodes) { (json, error) in
            //MARK: Change to main queue
            DispatchQueue.main.async {
                guard let json = json else {
                    if let error = error{
                        completion(Result.failure(error))
                    }else{
                        completion(Result.failure(.invalidData))
                    }
                    return
                }

                if let value = decode(json){
                    completion(.success(value))
                }else{
                    completion(.failure(.jsonParsingFailure))
                }
            }
        }
        task.resume()
    }
}
