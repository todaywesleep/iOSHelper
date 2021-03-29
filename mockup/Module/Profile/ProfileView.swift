//
//  ProfileView.swift
//  Mockup
//
//  Created by Vladislav Erchik on 8.12.20.
//

import SwiftUI

struct ProfileView: View {
    @ObservedObject var viewModel: ProfileViewModel
    
    var body: some View {
        ZStack(alignment: .top) {
            HStack {
                Spacer()
                Button(viewModel.isEditMode ? "Save" : "Edit") {
                    viewModel.toggleEditMode()
                }
                .padding([.leading, .trailing, .bottom], 16)
            }
            
            VStack(spacing: 16) {
                if let uiImage = viewModel.userImage {
                    Image(uiImage: uiImage)
                        .resizable()
                        .clipShape(Circle())
                        .frame(width: 80, height: 80)
                        .onTapGesture {
                            viewModel.isShowPhotoLibrary = true
                        }
                } else {
                    Circle()
                        .fill(Color.gray)
                        .frame(width: 80, height: 80)
                        .onTapGesture {
                            viewModel.isShowPhotoLibrary = true
                        }
                }
                
                TextField(
                    viewModel.user?.displayName ?? "Username not specified",
                    text: $viewModel.userName
                )
                .multilineTextAlignment(.center)
                .disabled(!viewModel.isEditMode)
                
                Text(viewModel.user?.email ?? "Email not specified")
                
                Spacer()
                
                Button("Logout") {
                    viewModel.logout()
                }
            }
        }.frame(
            maxWidth: .infinity,
            maxHeight: .infinity,
            alignment: .top
        )
        .sheet(isPresented: $viewModel.isShowPhotoLibrary) {
            ImagePicker(
                sourceType: .photoLibrary,
                delegate: viewModel
            )
        }
        .onAppear(perform: {
            viewModel.initProfile()
            viewModel.requestUserImage()
        })
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = ProfileViewModel(
            previewMode: true,
            parentNavigationStack: .init(easing: .default)
        )
        viewModel.previewMode = true
        
        return ProfileView(viewModel: viewModel)
    }
}
