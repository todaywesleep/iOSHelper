//
//  LoggerManager.swift
//  Mockup
//
//  Created by Vladislav Erchik on 11.12.20.
//

import Foundation
import FirebaseCrashlytics

struct LoggerManager {
    static func log(file: String = #file, line: Int = #line, message: String) {
        var fileName = file
        
        if let fileNameIndex = file.lastIndex(of: "/") {
            fileName.removeSubrange(file.startIndex...fileNameIndex)
        }
        
        print("[\(fileName)] line \(line): \(message)")
    }
}
