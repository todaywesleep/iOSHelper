import Foundation
import UIKit

///Used for handling navigation and passing data to screens
enum PushNavigatonType {
    case notificationName(object: PushResponse)
}

final class PushNavigatorManager {
    
    static var shared = PushNavigatorManager()
    var pushNavigatonType: PushNavigatonType?
    
    fileprivate init() {}

    private func checkPushType() {
        guard let pushNavigatonType = pushNavigatonType else {
            return
        }
        
        PushNavigator.shared.proceedToPushNavigatonType(pushNavigatonType)
        //Set to nil when some certain screen was opened to prevent handling the same pushType twice or more times
        self.pushNavigatonType = nil
    }
    
    func handleRemoteNotification(_ notification: [AnyHashable: Any]) {
        pushNavigatonType = NotificationParser.shared.handleNotification(notification)
        checkPushType()
    }
}
