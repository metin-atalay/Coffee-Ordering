//
//  Webservice.swift
//  HotCoffee
//
//  Created by Metin Atalay on 12.02.2022.
//

import Foundation
import UIKit

let serviceURL = "https://island-bramble.glitch.me/orders"

enum NetworkError: Error {
    case decodingError
    case domainError
    case urlError
}

enum HttpMethod: String {
    case get = "Get"
    case post = "Post"
}

struct Resource<T: Codable> {
    let url : URL
    var httpMethod: HttpMethod = .get
    var body: Data? = nil
}

class Webservice {
    
    func load<T>(resource : Resource<T>,completion: @escaping (Result<T,NetworkError>) -> Void){
      
        var requet = URLRequest(url: resource.url)
        requet.httpMethod = resource.httpMethod.rawValue
        requet.httpBody = resource.body
        requet.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        
        URLSession.shared.dataTask(with: requet) { data, response, error in
            
            guard let data = data, error == nil else {
                completion(.failure(.domainError))
                return
            }
            
            let result = try? JSONDecoder().decode(T.self, from: data)
            if let result = result {
                DispatchQueue.main.async {
                    completion(.success(result))
                }
            } else {
                completion(.failure(.decodingError))
            }
            
        }.resume()
        
    }
    
    
}
