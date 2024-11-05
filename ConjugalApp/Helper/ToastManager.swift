//
//  ToastManager.swift
//  ConjugalApp
//
//  Created by Kanishka Chaudhry on 05/11/24.
//

import SwiftUI

class ToastManager: ObservableObject {
    static let shared = ToastManager()
    private init() {}

    @Published var toastMessage: String? = nil
    @Published var isToastVisible: Bool = false

    func showToast(_ message: String) {
        DispatchQueue.main.async {
            self.toastMessage = message
            self.isToastVisible = true
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.isToastVisible = false
        }
    }
}

struct ToastView: View {
    @Binding var isToastVisible: Bool
    var message: String

    var body: some View {
        if isToastVisible {
            Text(message)
                .animation(.bouncy, value: isToastVisible)
                .foregroundColor(.white)
                .padding()
                .background(Color.black.opacity(0.8))
                .cornerRadius(10)
                .shadow(radius: 5)
                .animation(.easeInOut, value: isToastVisible)
                .padding(.horizontal, 30)
                .padding(.bottom, 20)
                .zIndex(1)
        }
    }
}
