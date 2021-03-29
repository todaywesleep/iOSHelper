//
//  Endpoint.swift
//  Mockup
//
//  Created by Vladislav Erchik on 14.12.20.
//

import Foundation

enum Endpoint {
    case news
    
    var string: String {
        switch self {
        case .news: return "\(NetworkService.baseUrl)deals"
        }
    }
    
    var url: URL {
        switch self {
        case .news:
            return URL(string: "\(NetworkService.baseUrl)deals")!
        }
    }
}
