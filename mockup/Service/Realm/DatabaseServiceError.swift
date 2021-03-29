//
//  DatabaseServiceError.swift
//  Alakine
//
//  Created by Vladislav Erchik on 10/2/20.
//

import Foundation

public protocol MappableError: Error {
    init(error: Error)
}

enum DatabaseServiceError: MappableError {
    case unknownError(message: String)

    public init(error: Error) {
        switch error {
        default:
            self = .unknownError(message: error.localizedDescription)
        }
    }
}
