//
//  MainViewController.swift
//  Mockup
//
//  Created by Vladislav Erchik on 7.12.20.
//

import Foundation

class MainViewModel: ObservableObject {
    let paginationViewModel = PaginationViewModel()
    lazy var profileViewModel = ProfileViewModel(parentNavigationStack: navigationStack)
    let settingsViewModel = SettingsViewModel()
    let navigationStack: NavigationStack
    
    @Published var activeTab = 1
    
    init(navigationStack: NavigationStack) {
        self.navigationStack = navigationStack
    }
}
