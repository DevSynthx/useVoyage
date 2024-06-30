//
//  EnterNameView.swift
//  project-z
//
//  Created by Inyene Etoedia on 20/06/2024.
//

import SwiftUI

struct EnterNameView: View {
    @Binding var username: String
    var body: some View {
        VStack (alignment: .leading, spacing: 0){
            Spacer()
            Text("Enter your name")
                .font(.system(size: 20, weight: .bold))
                .foregroundStyle(.white)
        Gap(h: 20)
            TextField("", text: $username)
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
        .padding(.horizontal, 10)
    }
}

#Preview {
    EnterNameView(username: .constant("David"))
        .background(.black)
}
