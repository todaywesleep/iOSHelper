//
//  AppViewModel.swift
//  mockup
//
//  Created by Vladislav Erchik on 3.12.20.
//

import Foundation
import Combine

class AppViewModel: ObservableObject {
    let navigationStack = NavigationStack(easing: .default)
    
    func navigateAccordingState() {
        navigationStack.push(
            AuthView(viewModel: .init(navigationStack: navigationStack))
        )
        
        if AuthService.shared.isSignedIn {
            let mainViewModel = MainViewModel(navigationStack: navigationStack)
            navigationStack.push(MainView(viewModel: mainViewModel))
        }
    }
}
