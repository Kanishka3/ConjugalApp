//
//  ContentView.swift
//  ConjugalApp
//
//  Created by Kanishka Chaudhry on 04/11/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = ViewModel()
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVStack(spacing: 16) {
                    ForEach(viewModel.displayItems.indices, id: \.self) { index in
                        if let model = viewModel.displayItems[safe: index] {
                            ProfileCard(profile: model, didSelectProfile: { isAccepted in
                                do {
                                    try viewModel.changeStatus(for: model.email, isAccepted: isAccepted)
                                } catch { }
                            })
                        }
                    }
                }
                .navigationTitle("Profiles")
                .onAppear {
                    Task {  @MainActor in
                        await viewModel.getProfiles()
                    }
                }
            }.scrollIndicators(.hidden)
        }
    }
}

#Preview {
    ContentView()
}

