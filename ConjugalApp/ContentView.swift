//
//  ContentView.swift
//  ConjugalApp
//
//  Created by Kanishka Chaudhry on 04/11/24.
//

import SwiftUI
import SDWebImageSwiftUI


struct ContentView: View {
    @StateObject var viewModel = ViewModel()
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVStack(spacing: 10) {
                    ForEach(viewModel.profiles.indices, id: \.self) { index in
                        if let model = viewModel.displayItems[safe: index] {
                            ProfileCard(profile: model, didSelectProfile: { isAccepted in
                                do {
                                    try viewModel.changeStatus(for: viewModel.profiles[index], isAccepted: isAccepted)
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
            }
        }
    }
}

struct ProfileCard: View {
    
    let profile: ProfileModel
    
    let didSelectProfile: (_ isAccepted: Bool) -> Void
    
    var body: some View {
        VStack(alignment: .center) {
            WebImage(url: URL(string: profile.imageUrl)) { image in
                image
                    .resizable() // Make the image resizable
                    .aspectRatio(contentMode: .fill) // Fill the frame and maintain aspect ratio
                    .frame(width: 200, height: 200) // Set your desired fixed size
                    .clipped() // Crop any overflow
            } placeholder: {
                Rectangle()
                    .foregroundColor(.gray)
                    .frame(width: 200, height: 200) // Match the frame of the placeholder
            }.clipShape(RoundedRectangle(cornerRadius: 16))
            Text(profile.name)
                .bold()
                .font(.title2)
                .foregroundStyle(.orange)
            
            Text(profile.address)
            
            HStack(spacing: 20) {
                if profile.didSelect {
                    if profile.didAccept == true {
                        Text("Accepted")
                    } else if profile.didAccept == false {
                        Text("Rejected")
                    }
                } else {
                    CircularIconButton(systemName: "checkmark", color: .green) {
                        didSelectProfile(true)
                    }
                    
                    CircularIconButton(systemName: "xmark", color: .blue) {
                        didSelectProfile(false)
                    }
                }
            }
        }
        .padding()
        .frame(width: Helpers.phoneWidth - (GlobalConstants.sidePadding * 2))
        .frame(maxHeight: .infinity, alignment: .center)
    }
}

#Preview {
    ContentView()
}

