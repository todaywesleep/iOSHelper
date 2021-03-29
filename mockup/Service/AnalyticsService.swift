//
//  AnalyticsService.swift
//  Mockup
//
//  Created by Vladislav Erchik on 11.12.20.
//

import Foundation
import FirebaseAnalytics
import FirebaseAuth

enum AnalyticEvent {
    case signIn(User)
    case signUp(User)
    case custom(name: String, _ params: [String: Any]?)
}

class AnalyticsService {
    static var shared = AnalyticsService()
    private init() {}
    
    func sendEvent(_ event: AnalyticEvent) {
        switch event {
        case .signIn(let user):
            Analytics.logEvent(AnalyticsEventLogin, parameters: [
                AnalyticsParameterMethod: "email",
                AnalyticsParameterItemID: user.uid,
                AnalyticsParameterItemName: user.email ?? "N/A"
            ])
        case .signUp(let user):
            Analytics.logEvent(AnalyticsEventSignUp, parameters: [
                AnalyticsParameterMethod: "email",
                AnalyticsParameterItemID: user.uid,
                AnalyticsParameterItemName: user.email ?? "N/A"
            ])
        case let .custom(name, params):
            Analytics.logEvent(name, parameters: params)
        }
    }
}
