//
//  Helper.swift
//  Assignment
//
//  Created by ToanHT on 18/02/2022.
//

import Foundation


public struct Helper {
    public static func readLocalFile(forName name: String) -> Data? {
        do {
            if let bundlePath = Bundle.main.path(forResource: name,
                                                 ofType: "json"),
                let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8) {
                return jsonData
            }
        } catch {
            print(error)
        }
        
        return nil
    }
    
    public static func parseArray<T: Codable>(jsonData: Data) -> [T]? {
        do {
            let decodedData = try JSONDecoder().decode([T].self,
                                                       from: jsonData)
            return decodedData
        } catch {
            print("decode error")
            return nil
            
        }
    }
    
    public static func parse<T: Codable>(jsonData: Data) -> T? {
        do {
            let decodedData = try JSONDecoder().decode(T.self,
                                                       from: jsonData)
            return decodedData
        } catch {
            print("decode error")
            return nil
            
        }
    }
    
    static func parseDict<T:Codable>(jsonData: Data) -> [String:T]? {
        do {
            let decodedData = try JSONDecoder().decode([String: T].self,
                                                       from: jsonData)
            return decodedData
        } catch {
            print("decode error")
            return nil
            
        }
    }
    
    public static func loadJson(fromURLString urlString: String,
                          completion: @escaping (Result<Data, Error>) -> Void) {
        if let url = URL(string: urlString) {
            let urlSession = URLSession(configuration: .default).dataTask(with: url) { (data, response, error) in
                if let error = error {
                    completion(.failure(error))
                }
                if let data = data {
                    completion(.success(data))
                }
            }
            urlSession.resume()
        }
    }
    
    static func encodeData<T: Codable>(withDict dict: [String:T]) -> String? {
        let encoder = JSONEncoder()
        if let jsonData = try? encoder.encode(dict) {
            if let jsonString = String(data: jsonData, encoding: .utf8) {
                return jsonString

            }
        }
        return nil
    }
    
    /**
     self.saveJsonToFile(withFilename: "myJsonData", jsonString: jsonString)
     if let data = self.loadJSON(withFilename: "myJsonData") {
         let json : [String: T]? = self.parseDict(jsonData: data)
         if let json = json {
             print("ToanHT json ne \(json)")
         }
     }
     */
    
    
    static func saveJsonToFile(withFilename filename: String, jsonString: String) {
        if let jsonData = jsonString.data(using: .utf8),
            let documentDirectory = FileManager.default.urls(for: .documentDirectory,
                                                             in: .userDomainMask).first {
            let pathWithFileName = documentDirectory.appendingPathComponent(filename)
            do {
                try jsonData.write(to: pathWithFileName)
            } catch {
                // handle error
            }
        }
    }
    
    static func loadJSON(withFilename filename: String) -> Data? {
        do {
        if let documentDirectory = FileManager.default.urls(for: .documentDirectory,
                                                               in: .userDomainMask).first {
            let pathWithFileName = documentDirectory.appendingPathComponent(filename)
            let data = try Data(contentsOf: pathWithFileName)
            return data
        }
        } catch {
            print(error)
        }
        return nil
    }
}

