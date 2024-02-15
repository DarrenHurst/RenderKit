//
//  File.swift
//  
//
//  Created by Darren Hurst on 2023-11-21.
//

import Foundation
import SwiftUI
 
struct Network {
    func fetch<T: Codable>(from urlString: String) async throws -> T {
        guard let url = URL(string: urlString) else  {
            throw URLError(.badURL)
        }
        let (data, response) = try await URLSession.shared.data(from: url)
        
        if let statusCode = (response as? HTTPURLResponse)?.statusCode  {
            if statusCode == 200 { // OK
                let result = try JSONDecoder().decode(T.self, from: data)
                return result
            }
            // 300 and 400
            else if statusCode == 500 {
                throw URLError(.badServerResponse)
            }
        }
        throw URLError(.unknown)
    }
}

extension URL
{
    var parameters: [String: String?]?
    {
        if  let components = URLComponents(url: self, resolvingAgainstBaseURL: false),
            let queryItems = components.queryItems
        {
            var parameters = [String: String?]()
            for item in queryItems {
                parameters[item.name] = item.value
            }
            return parameters
        } else {
            return nil
        }
    }
}


