//
//  ProfileViewModel.swift
//  Mockup
//
//  Created by Vladislav Erchik on 8.12.20.
//

import Foundation
import Combine
import Firebase
import UIKit

class ProfileViewModel: NSObject, ObservableObject {
    private let userService = UserService.shared
    private let authService = AuthService.shared
    private var cancellables = Set<AnyCancellable>()
    private var parentNavigationStack: NavigationStack
    var previewMode: Bool
    
    init(previewMode: Bool = false, parentNavigationStack: NavigationStack) {
        self.previewMode = previewMode
        self.parentNavigationStack = parentNavigationStack
    }
    
    @Published var error: String?
    @Published var userImage: UIImage?
    @Published var isShowPhotoLibrary = false
    @Published var isEditMode = false
    @Published var userName = ""
    
    var user: User? {
        previewMode ? nil : userService.user
    }
    
    func toggleEditMode() {
        isEditMode.toggle()
        
        if isEditMode == false {
            setUserName()
        }
    }
    
    func initProfile() {
        self.userName = user?.displayName ?? "Username not specified"
    }
    
    func requestUserImage() {
        guard !previewMode else { return }
        
        userService.userImage.sink { completion in
            switch completion {
            case .failure(let error):
                if let unwrapped = error as? UserServiceError, unwrapped != .emptyData {
                    self.error = error.localizedDescription
                }
            default: break
            }
        } receiveValue: { image in
            self.userImage = image
        }
        .store(in: &cancellables)
    }
    
    func logout() {
        authService.logout().sink { _ in
            self.parentNavigationStack.pop()
        } receiveValue: { _ in }
        .store(in: &cancellables)
    }
    
    private func setUserName() {
        userService.setUserName(name: userName)
            .sink { completion in
                switch completion {
                case .failure(let error):
                    print("[PROFILE] Can't set userName with error: \(error)")
                default: break
                }
            } receiveValue: { [weak self] _ in
                print("[PROFILE] UserName updated. New userName: \(self?.userName ?? "Instance deallocated")")
            }
            .store(in: &cancellables)
    }
}

extension ProfileViewModel: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        userImage = image
        isShowPhotoLibrary = false
        
        userService.uploadUserImage(image).sink { completion in
            switch completion {
            case .failure(let error):
                print("[TEST] Error: \(error)")
                self.error = error.localizedDescription
            default: break
            }
            
            print("[TEST] Finished")
        } receiveValue: { _ in
            print("[TEST] Received value")
        }
        .store(in: &cancellables)
    }
}
