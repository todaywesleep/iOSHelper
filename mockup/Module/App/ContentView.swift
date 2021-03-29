//
//  ContentView.swift
//  mockup
//
//  Created by Vladislav Erchik on 3.12.20.
//

import SwiftUI
import CoreData

struct ContentView: View {
    private let viewModel = AppViewModel()
    
    var body: some View {
        NavigationStackView(
            transitionType: .default,
            navigationStack: viewModel.navigationStack) {
            Text("...")
        }
        .onAppear(perform: {
            viewModel.navigateAccordingState()
        })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
