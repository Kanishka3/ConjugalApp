//
//  CircularIconButton.swift
//  ConjugalApp
//
//  Created by Kanishka Chaudhry on 05/11/24.
//

import SwiftUI 

struct CircularIconButton: View {
    let systemName: String
    let color: Color
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Image(systemName: systemName)
                .resizable()
                .scaledToFit()
                .foregroundColor(color)
                .padding(7)
        }
        .frame(width: 33, height: 33)
        .background(Color.white)
        .clipShape(Circle())
        .overlay(Circle().stroke(color, lineWidth: 1))
        .buttonStyle(PlainButtonStyle())
    }
}
