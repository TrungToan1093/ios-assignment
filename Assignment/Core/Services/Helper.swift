//
//  Helper.swift
//  Assignment
//
//  Created by ToanHT on 18/02/2022.
//

import Foundation


public struct Helper {
    public static var kCacheAPI_MEProfile = "kCacheAPI_MEProfile"
    
    public static func loadCacheJsonAPI(){
        guard let path = Bundle.main.path(forResource: "cities", ofType: "json") else { return }
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
            let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
            print("ToanHT \(jsonResult)")
            
//            if let jsonResult = jsonResult as? Dictionary<String, AnyObject>, let person = jsonResult["person"] as? [Any] {
//                // do stuff
//            }
        } catch {
            print("ToanHT handle error")
            // handle error
        }
    }
    
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
}

