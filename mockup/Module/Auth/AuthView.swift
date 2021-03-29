//
//  AuthView.swift
//  mockup
//
//  Created by Vladislav Erchik on 3.12.20.
//

import SwiftUI

struct AuthView: View {
    @ObservedObject var viewModel: AuthViewModel
    
    var body: some View {
        VStack(alignment: .center, spacing: 16) {
            Image("Logo")
                .frame(minWidth: 0, maxWidth: .infinity)
                .frame(height: 300)
            
            Spacer()
            
            TextField(
                "Email",
                text: $viewModel.email
            )
            .emailInput()
            
            SecureField(
                "Password",
                text: $viewModel.password
            )
            
            Spacer()
            
            Button("Sign in") {
                viewModel.authenticate()
            }
            
            Button("Sign up") {
                viewModel.register()
            }
        }
        .padding(.horizontal, 16)
        .background(Color.white)
        .withLoading(state: $viewModel.isFetchInProgress)
        .alert(
            isPresented: .constant(viewModel.errorContent != nil),
            content: {
                Alert(
                    title: Text("Error"),
                    message: Text(viewModel.errorContent ?? ""),
                    dismissButton: Alert.Button.cancel({
                        viewModel.errorContent = nil
                    })
                )
        })
    }
}

struct AuthView_Previews: PreviewProvider {
    static var previews: some View {
        AuthView(
            viewModel: .init(
                navigationStack: .init(easing: .default)
            )
        )
    }
}
