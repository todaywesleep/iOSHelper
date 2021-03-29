//
//  EmailInput.swift
//  Mockup
//
//  Created by Vladislav Erchik on 7.12.20.
//

import Foundation
import SwiftUI

struct EmailInput: ViewModifier {
    func body(content: Content) -> some View {
        content
            .textContentType(.emailAddress)
            .autocapitalization(.none)
            .disableAutocorrection(true)
    }
}

extension View {
    func emailInput() -> some View {
        modifier(EmailInput())
    }
}
