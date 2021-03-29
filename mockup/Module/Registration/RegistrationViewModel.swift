//
//  RegistrationViewModel.swift
//  mockup
//
//  Created by Vladislav Erchik on 4.12.20.
//

import Foundation
import Combine

class RegistrationViewModel: ObservableObject {
    let navigationStack: NavigationStack
    private var cancellables = Set<AnyCancellable>()
    
    @Published var password = ""
    @Published var repeatPassword = ""
    @Published var login = ""
    
    @Published var isFetchInProgress = false
    @Published var errorContent: String?
    
    init(navigationStack: NavigationStack) {
        self.navigationStack = navigationStack
    }
    
    func register() {
        AuthService.shared.signUp(email: login, password: password)
            .sink { [weak self] completion in
                switch completion {
                case .failure(let error):
                    self?.errorContent = error.localizedDescription
                default: break
                }
                
                self?.isFetchInProgress = false
            } receiveValue: { user in
                AnalyticsService.shared.sendEvent(.signUp(user))
                print("[REGISTRATION] User registered: \(user)")
            }
            .store(in: &cancellables)
    }
    
    func back() {
        navigationStack.pop()
    }
}
