//
//  NotificationParser.swift
//  GeoLog
//


import Foundation

class NotificationParser {
    static let shared = NotificationParser()
    private init() { }
    
    func handleNotification(_ userInfo: [AnyHashable : Any]) -> PushNavigatonType? {
        guard (userInfo["aps"] as? [String: Any]) != nil else { return nil}

        do {
            let _ = try JSONSerialization.data(withJSONObject: userInfo, options: .prettyPrinted)
            return .none
        } catch let error {
            print(error.localizedDescription)
        }
        return nil
    }
}
