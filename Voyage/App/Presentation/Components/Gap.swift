//
//  Gap.swift
//  project-z
//
//  Created by Inyene Etoedia on 06/06/2024.
//

import SwiftUI

struct Gap: View {
    var h: CGFloat = 5
    var w: CGFloat = 5
    var body: some View {
        Spacer()
            .frame(width: w, height: h)
    }
}
