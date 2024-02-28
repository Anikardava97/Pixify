//
//  IconAndLabelView.swift
//  Pixify
//
//  Created by Ani's Mac on 28.02.24.
//

import SwiftUI

struct IconAndLabelView: View {
    // MARK: - Properties
    var iconName: String
    var text: String
    
    // MARK: - Body
    var body: some View {
        HStack(spacing: 8) {
            SwiftUI.Image(systemName: iconName)
                .frame(width: 20, height: 20)
                .foregroundColor(.white)
            Text(text)
                .font(.system(size: 16))
                .foregroundColor(.white)
        }
        .padding(EdgeInsets(top: 12, leading: 16, bottom: 12, trailing: 16))
        .background(Color.customAccentColor)
        .cornerRadius(24)
    }
}
