//
//  MainView.swift
//  Mockup
//
//  Created by Vladislav Erchik on 7.12.20.
//

import Foundation
import SwiftUI

struct MainView: View {
    @ObservedObject var viewModel: MainViewModel
    
    var body: some View {
//        NavigationStackView(
//            transitionType: .default,
//            navigationStack: viewModel.navigationStack) {
            TabView(selection: $viewModel.activeTab) {
                SettingsView(
                    viewModel: viewModel.settingsViewModel
                )
                .tabItem {
                    Text("Settings")
                }
                .tag(0)
                
                PaginationView(
                    viewModel: viewModel.paginationViewModel
                ).tabItem {
                    Text("Pagination")
                }
                .tag(1)
                
                ProfileView(
                    viewModel: viewModel.profileViewModel
                ).tabItem {
                    Text("Profile")
                }
                .tag(2)
            }
//        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = MainViewModel(
            navigationStack: .init(easing: .default)
        )
        return MainView(viewModel: viewModel)
    }
}
