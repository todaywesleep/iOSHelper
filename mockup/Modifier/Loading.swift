//
//  Loading.swift
//  mockup
//
//  Created by Vladislav Erchik on 3.12.20.
//

import SwiftUI

struct LoadingView: View {
    @State private var shouldAnimate = false
        
    var body: some View {
        HStack {
            Circle()
                .fill(Color.blue)
                .frame(width: 20, height: 20)
                .scaleEffect(shouldAnimate ? 1.0 : 0.5)
                .animation(Animation.easeInOut(duration: 0.5).repeatForever())
            Circle()
                .fill(Color.blue)
                .frame(width: 20, height: 20)
                .scaleEffect(shouldAnimate ? 1.0 : 0.5)
                .animation(Animation.easeInOut(duration: 0.5).repeatForever().delay(0.3))
            Circle()
                .fill(Color.blue)
                .frame(width: 20, height: 20)
                .scaleEffect(shouldAnimate ? 1.0 : 0.5)
                .animation(Animation.easeInOut(duration: 0.5).repeatForever().delay(0.6))
        }
        .onAppear {
            self.shouldAnimate = true
        }
    }
}

struct LoadingModifier: ViewModifier {
    @Binding var isLoading: Bool
    
    init(isLoading: Binding<Bool>) {
        self._isLoading = isLoading
    }
    
    func body(content: Content) -> some View {
        GeometryReader { proxy in
            ZStack {
                content
                
                if isLoading {
                    LoadingView()
                        .frame(
                            maxWidth: .infinity,
                            maxHeight: .infinity
                        )
                        .background(Color.black.opacity(0.1))
                        .padding(.bottom, -proxy.safeAreaInsets.bottom)
                        .padding(.top, -proxy.safeAreaInsets.top)
                }
            }
        }
    }
}

extension View {
    func withLoading(state: Binding<Bool>) -> some View {
        modifier(LoadingModifier(isLoading: state))
    }
}

struct Loading_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            List {
                Text("1")
                Text("2")
                Text("3")
            }
            
            Spacer()
            
            Button("Test title") {
                
            }
        }
        .withLoading(state: .constant(true))
    }
}
