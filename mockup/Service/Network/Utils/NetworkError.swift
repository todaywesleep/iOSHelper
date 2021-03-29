//
//  NetworkError.swift
//  Mockup
//
//  Created by Vladislav Erchik on 14.12.20.
//

import Foundation

enum NetworkError: Error, LocalizedError {
    case unknown
    case decodingError
    
    var errorDescription: String? { "" }
}
