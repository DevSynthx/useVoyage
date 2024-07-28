//
//  EnterNameView.swift
//  project-z
//
//  Created by Inyene Etoedia on 20/06/2024.
//

import SwiftUI

struct EnterNameView: View {
    @Binding var username: String
    @FocusState.Binding var isFocused: Bool
    var body: some View {
        VStack (alignment: .leading, spacing: 0){
            Spacer()
            Text("Enter your name")
                .font(.customx(.bold, size: 25))
                .foregroundStyle(.white)
        Gap(h: 25)
            TextField("", text: $username)
                .focused($isFocused)
                .keyboardType(.asciiCapable)
                .textContentType(.name)
                .underlineTextField()
                .onChange(of: username, initial: false, { oldValue, newValue in
                    // Filter out non-alphabet characters
                    let filtered = newValue.filter { $0.isLetter }
                    if filtered != newValue {
                        username = filtered
                    }
                })

            Spacer()
        }
        .padding(.horizontal, 25)
    }
}

#Preview {
    EnterNameView(username: .constant("David"), isFocused: FocusState<Bool>().projectedValue)
        .background(.black)
}
