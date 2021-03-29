//
//  UserService.swift
//  Mockup
//
//  Created by Vladislav Erchik on 8.12.20.
//

import Foundation
import Firebase
import Combine

enum UserServiceError: Error, LocalizedError {
    case emptyData
    case userNotFound
    case unknown
    
    var errorDescription: String? {
        switch self {
        case .emptyData: return "Empty data"
        case .userNotFound: return "User not found"
        case .unknown: return "Unknown error"
        }
    }
}

class UserService {
    private struct UserConstants {
        static let avatarsStorage = "avatars"
        
        static let avatarKey = "avatar"
    }
    
    static var shared = UserService()
    private init() {}
    
    var user: User? {
        Auth.auth().currentUser
    }
    
    var userImage: Future<UIImage, Error> {
        .init { (promise: @escaping Future<UIImage, Error>.Promise) in
            guard let uid = self.user?.uid else {
                promise(.failure(UserServiceError.userNotFound))
                return
            }
            
            Storage.storage()
                .reference()
                .child(UserConstants.avatarsStorage)
                .child("\(uid).png")
                // 30 MB
                .getData(maxSize: 1024 * 1024 * 30) { data, error in
                    if let data = data, let image = UIImage(data: data) {
                        promise(.success(image))
                    } else {
                        promise(.failure(error ?? UserServiceError.unknown))
                    }
                }
        }
    }
    
    func setUserName(name: String) -> Future<Void, Error> {
        .init { (observer: @escaping Future<Void, Error>.Promise) in
            guard let user = self.user else {
                observer(.failure(UserServiceError.emptyData))
                return
            }
            
            let changeRequest = user.createProfileChangeRequest()
            changeRequest.displayName = name
            
            changeRequest.commitChanges { error in
                if let error = error {
                    observer(.failure(error))
                } else {
                    observer(.success(()))
                }
            }
        }
    }
    
    func uploadUserImage(_ image: UIImage?) -> Future<Void, Error> {
        .init { (promise: @escaping Future<Void, Error>.Promise) in
            guard let imageData = image?.pngData(), let uuid = self.user?.uid else {
                promise(.failure(UserServiceError.emptyData))
                return
            }
            
            let imageRef = Storage.storage()
                .reference()
                .child(UserConstants.avatarsStorage)
                .child("\(uuid).png")
            
            imageRef
                .putData(imageData, metadata: nil, completion: { (metadata, error) in
                    if let _ = metadata {
                        promise(.success(()))
                    } else {
                        promise(.failure(error ?? UserServiceError.unknown))
                    }
                })
        }
    }
}
