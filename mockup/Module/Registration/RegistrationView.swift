//
//  RegistrationView.swift
//  mockup
//
//  Created by Vladislav Erchik on 4.12.20.
//

import SwiftUI

struct RegistrationView: View {
    @ObservedObject var viewModel: RegistrationViewModel
    
    var body: some View {
        ZStack(alignment: .top) {
            HStack {
                Button("Back") {
                    viewModel.back()
                }
                
                Spacer()
            }
            
            VStack(spacing: 16) {
                Image("Logo")
                    .frame(minWidth: 0)
                    .frame(height: 300)
                
                Spacer()
                
                TextField("Email", text: $viewModel.login)
                    .emailInput()
                
                SecureField("Password", text: $viewModel.password)
                    .textContentType(.newPassword)
                
                SecureField("Repeat password", text: $viewModel.repeatPassword)
                    .textContentType(.password)
                
                Spacer()
                
                Button("Register") {
                    viewModel.register()
                }
            }
        }
        .padding(.horizontal, 16)
        .background(Color.white)
        .withLoading(state: $viewModel.isFetchInProgress)
        .alert(
            isPresented: .constant(viewModel.errorContent != nil)) {
            Alert(
                title: Text("Error"),
                message: Text(viewModel.errorContent!),
                dismissButton: Alert.Button.cancel({
                    viewModel.errorContent = nil
                })
            )
        }
    }
}

struct RegistrationView_Previews: PreviewProvider {
    static var previews: some View {
        RegistrationView(
            viewModel: .init(
                navigationStack: .init(easing: .default)
            )
        )
    }
}
