//
//  PushResponse.swift
//  GeoLog

import Foundation

enum PushEventType: String, Codable {
    // TODO: Add event types here
    case undefined

    init(from decoder: Decoder) throws {
        let label = try decoder.singleValueContainer().decode(String.self)
        switch label {
        default: self = .undefined
       }
    }
}

struct PushResponse: Codable {
    // TODO: Add push response here
}
