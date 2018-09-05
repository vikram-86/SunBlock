//
//  PersistanceService.swift
//  Sunblock
//
//  Created by Suthananth Arulanatham on 26.08.2018.
//  Copyright © 2018 Shortcut. All rights reserved.
//

import Foundation

class PersistanceService {

    fileprivate init(){}

    enum Directory {

        case documents
        case caches

    }

    static fileprivate func getURL(for directory: Directory) -> URL {
        var searchPathDirectory: FileManager.SearchPathDirectory

        switch directory{
        case .documents:
            searchPathDirectory = .documentDirectory
        case .caches:
            searchPathDirectory = .cachesDirectory
        }

        if let url = FileManager.default.urls(for: searchPathDirectory, in: .userDomainMask).first{
            return url
        }else{
            fatalError("Could not create URL for spesific directory")
        }
    }

    static func store<T: Encodable>(_ object: T, to directory: Directory, as fileName: String){
        let url = getURL(for: directory).appendingPathComponent(fileName, isDirectory: false)

        let encoder = JSONEncoder()
        do{
            let data = try encoder.encode(object)
            if FileManager.default.fileExists(atPath: url.path){
                try FileManager.default.removeItem(at: url)
            }
            FileManager.default.createFile(atPath: url.path, contents: data, attributes: nil)
        }catch{
            fatalError(error.localizedDescription)
        }
    }

    static func retrieve<T: Decodable>(_ filename: String,
                                       from directory: Directory,
                                       as type: T.Type) -> T{
        let url = getURL(for: directory).appendingPathComponent(filename, isDirectory: false)

        if !FileManager.default.fileExists(atPath: url.path){
            fatalError("File at path \(url.path) does not exist!")
        }

        if let data = FileManager.default.contents(atPath: url.path) {
            let decoder = JSONDecoder()
            do{
                let model = try decoder.decode(type, from: data)
                return model
            }catch{
                fatalError("No data at \(url.path)!")
            }
        }else{
            fatalError("No data at \(url.path)!")
        }
    }

    static func clear(_ directory: Directory){
        let url = getURL(for: directory)
        do{
            let contents = try FileManager.default.contentsOfDirectory(at: url, includingPropertiesForKeys: nil, options: [])
            for fileURL in contents{
                try FileManager.default.removeItem(at: fileURL)
            }
        }catch{
            fatalError(error.localizedDescription)
        }
    }

    static func remove(_ fileName: String, from directory: Directory){
        let url = getURL(for: directory).appendingPathComponent(fileName, isDirectory: false)
        if FileManager.default.fileExists(atPath: url.path){
            do{
                try FileManager.default.removeItem(at: url)
            }catch{
                fatalError(error.localizedDescription)
            }
        }
    }

    static func fileExists(_ fileName: String, in directory: Directory) -> Bool {
        let url = getURL(for: directory).appendingPathComponent(fileName, isDirectory: false)
        return FileManager.default.fileExists(atPath: url.path)
    }
}
