//
//  ActionButton.swift
//  project-z
//
//  Created by Inyene Etoedia on 20/06/2024.
//

import SwiftUI

struct AppButton: View {
    let action: ()->Void
    var title: String = "Continue"
    var textColor: Color = .black
    var bgColor: Color = .white
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.system(size: 12))
                .foregroundStyle(textColor)
                .padding(.horizontal, 15)
                .padding(.vertical, 5)
        }
        .buttonStyle(.borderedProminent)
        .accentColor(bgColor)
    }
}

#Preview {
    AppButton(action: {})
}
