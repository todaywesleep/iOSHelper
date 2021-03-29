//
//  CrashlyticsService.swift
//  Mockup
//
//  Created by Vladislav Erchik on 11.12.20.
//

import Foundation
import FirebaseCrashlytics

class CrashlyticsService {
    static var shared = CrashlyticsService()
    private lazy var crashlytics = Crashlytics.crashlytics()
    
    private init() {}
    
    func reportError(_ error: Error) {
        crashlytics.record(error: error)
    }
}
