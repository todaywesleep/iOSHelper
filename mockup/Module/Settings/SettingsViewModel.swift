//
//  SettingsViewModel.swift
//  Mockup
//
//  Created by Vladislav Erchik on 11.12.20.
//

import Foundation
import Combine
import SwiftUI

class SettingsViewModel: ObservableObject {
    @Published var isInDarkMode = false {
        didSet {
            SceneDelegate.shared?.window!.overrideUserInterfaceStyle = isInDarkMode ? .dark : .light
        }
    }
}
