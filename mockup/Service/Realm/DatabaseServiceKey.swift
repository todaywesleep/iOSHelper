//
//  DatabaseServiceKey.swift
//  Alakine
//
//  Created by Vladislav Erchik on 10/2/20.
//

import Foundation

enum DatabaseServiceKey: String, RawRepresentable {
    case user
    
    var description: String { rawValue }
}
