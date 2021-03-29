//
//  NetworkService.swift
//  Mockup
//
//  Created by Vladislav Erchik on 7.12.20.
//

import Foundation
import Combine
import UIKit.UIApplication

class NetworkService {
    static let baseUrl = "https://www.cheapshark.com/api/1.0/"
    static var shared = NetworkService()
    
    private let session = URLSession.shared
    var customDecoder: JSONDecoder?
    
    private init() {}
    
    func request<T: Decodable>(url: URL, type: RequestMethod = .GET, parameters: [String: String]? = nil, body: [String: Any]? = nil) -> AnyPublisher<T, Error> {
        print("[URLSESSION] Request: \(url)")
        
        var request = URLRequest(url: url)
        request.httpMethod = type.rawValue
        
        (parameters ?? [:]).forEach { parameter in
            request.addValue(parameter.key, forHTTPHeaderField: parameter.value)
        }
        
        if let body = body, let json = try? JSONSerialization.data(withJSONObject: body, options: []) {
            request.httpBody = json
        }
        
        return URLSession.DataTaskPublisher(request: URLRequest(url: url), session: .shared)
            .tryMap { data, response -> T in
                guard let httpResponse = response as? HTTPURLResponse, 200..<300 ~= httpResponse.statusCode else {
                    throw NetworkError.unknown
                }
                
                do {
                    let decoder = self.customDecoder ?? JSONDecoder()
                    return try decoder.decode(T.self, from: data)
                } catch {
                    throw error
                }
            }
            .eraseToAnyPublisher()
    }
}
