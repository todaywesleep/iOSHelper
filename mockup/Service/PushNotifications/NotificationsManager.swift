//
//  NotificationsManager.swift
//  GeoLog
//

import Foundation
import UserNotifications
import UIKit
import FirebaseMessaging

class NotificationsManager: NSObject, UNUserNotificationCenterDelegate {
    static let shared = NotificationsManager()
    let center = UNUserNotificationCenter.current()

    // MARK: - Notifications
    override init() {
        super.init()
        center.delegate = self
    }

    func requestNotificationPermission() {
        let options: UNAuthorizationOptions = [.alert, .sound, .badge]
        center.requestAuthorization(options: options) { granted, _ in
            if !granted {
                // Show alert
                print("[TODO] Show alert with notification permissions denied access")
            } else {
                DispatchQueue.main.async {
                    NotificationsManager.shared.registerForRemoteNotifications()
                }
            }
        }
    }

    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        let actionIdentifier = response.actionIdentifier
        let content = response.notification.request.content
        let info = content.userInfo
        switch actionIdentifier {
        case UNNotificationDefaultActionIdentifier: // Notification was dismissed by user
            PushNavigatorManager.shared.handleRemoteNotification(info)
            completionHandler()
        default:
            completionHandler()
        }
    }
    
    func userNotificationCenter(_: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert, .sound, .badge])
    }
    
    func checkIfAppWasLaunchedFromNotification(_ launchOptions: [UIApplication.LaunchOptionsKey: Any]?) {
        //Check if app was opened by clicking on push
        if let notification = launchOptions?[UIApplication.LaunchOptionsKey.remoteNotification] as? [AnyHashable : Any] {
            Messaging.messaging().appDidReceiveMessage(notification)
        }
    }
    
    //MARK: - Private
    private func registerForRemoteNotifications() {
        UIApplication.shared.registerForRemoteNotifications()
    }
}
