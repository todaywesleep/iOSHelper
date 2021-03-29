//
//  AuthViewModel.swift
//  mockup
//
//  Created by Vladislav Erchik on 3.12.20.
//

import Foundation
import Combine
import SwiftUI
import FirebaseAuth

class AuthViewModel: ObservableObject {
    let navigationStack: NavigationStack
    private var cancellables = Set<AnyCancellable>()
    
    @Published var email: String = ""
    @Published var password: String = ""
    
    @Published var isFetchInProgress = false
    @Published var errorContent: String?
    
    init(navigationStack: NavigationStack) {
        self.navigationStack = navigationStack
    }
    
    func authenticate() {
        isFetchInProgress = true
        
        AuthService.shared
            .signIn(email: email, password: password)
            .sink { [weak self] (completion) in
                switch completion {
                case .failure(let error):
                    self?.errorContent = error.localizedDescription
                default: break
                }
                
                self?.isFetchInProgress = false
            } receiveValue: { [weak self] user in
                guard let self = self else { return }
                AnalyticsService.shared.sendEvent(.signIn(user))
                let viewModel = MainViewModel(navigationStack: self.navigationStack)
                let mainView = MainView(viewModel: viewModel)
                self.navigationStack.push(mainView)
                print("[AUTH] User received: \(user)")
            }
            .store(in: &cancellables)
    }
    
    func register() {
        let registrationVM = RegistrationViewModel(navigationStack: navigationStack)
        let registrationView = RegistrationView(viewModel: registrationVM)
        
        navigationStack.push(registrationView)
    }
}
