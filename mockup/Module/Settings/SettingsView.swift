//
//  SettingsView.swift
//  Mockup
//
//  Created by Vladislav Erchik on 11.12.20.
//

import SwiftUI

struct SettingsView: View {
    @ObservedObject var viewModel = SettingsViewModel()
    
    var body: some View {
        VStack {
            Text("Settings")
                .font(.title)
            
            Spacer()
            
            HStack {
                Text("Dark mode")
                
                Toggle(
                    "Dark mode",
                    isOn: $viewModel.isInDarkMode
                ).labelsHidden()
            }
            
            Spacer()
        }
        .frame(alignment: .center)
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
