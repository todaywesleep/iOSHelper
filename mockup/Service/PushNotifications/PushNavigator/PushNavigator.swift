import Foundation
import UIKit

final class PushNavigator {
    static let shared = PushNavigator()
//    private let networkManager: NetworkManagerRoomsProtocol = WebSocketManager.shared/
    private var response: PushResponse?
    private var roomToOpen: Int?
    private var connectionAction: ((Bool) -> ())?
    private var privateChatVC: UIViewController?
    private var privateParentRoomId: Int?
    
    private init() {
        prepareObservers()
    }
    
    func proceedToPushNavigatonType(_ type: PushNavigatonType) {
        switch type {
        case let .notificationName(object):
            print("[NOTIFICATIONS] Received object: \(object)")
        }
    }
    
    //MARK: - Private
    private func removeObververs() {
        
    }
    
    private func prepareObservers() {
        
    }
}
