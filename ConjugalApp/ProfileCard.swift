//
//  ProfileCard.swift
//  ConjugalApp
//
//  Created by Kanishka Chaudhry on 05/11/24.
//

import SwiftUI
import SDWebImageSwiftUI

struct ProfileCard: View {
    
    @ObservedObject var profile: ProfileModel
    
    private let cardWidth = Helpers.phoneWidth - (GlobalConstants.sidePadding * 2)
    private let imageShape = RoundedRectangle(cornerRadius: GlobalConstants.cornerRadius)
    
    let didSelectProfile: (_ isAccepted: Bool) -> Void
    
    var body: some View {
        VStack(alignment: .center) {
            WebImage(url: URL(string: profile.imageUrl)) { image in
                image
                    .resizable() // Make the image resizable
                    .aspectRatio(contentMode: .fill) // Fill the frame and maintain aspect ratio
                    .frame(width: 120, height: 120) // Set your desired fixed size
                    .clipped() // Crop any overflow
            } placeholder: {
                Rectangle()
                    .foregroundColor(.orange.opacity(0.8))
                    .frame(width: 120, height: 120) // Match the frame of the placeholder
            }
            .clipShape(imageShape)
            .overlay(imageShape.stroke(Color.black, lineWidth: 1))

            
            Text(profile.name)
                .bold()
                .font(.title2)
                .foregroundStyle(.orange)
            
            Text(profile.address)
            
            HStack(spacing: 20) {
                switch profile.state {
                case .accepted, .rejected:
                    Text(profile.state.title)
                        .font(.title3)
                case .notDecided:
                    CircularIconButton(systemName: "checkmark", color: .green) {
                        didSelectProfile(true)
                    }
                    
                    CircularIconButton(systemName: "xmark", color: .blue) {
                        didSelectProfile(false)
                    }
                }
            }
            .frame(width: cardWidth, alignment: .center)
            .padding()
            .background(profile.state.isDecided ? .orange : .clear)
        }
        .animation(.bouncy, value: profile.state)
        .padding(EdgeInsets(top: 12, leading: 12, bottom: 0, trailing: 12))
        .frame(width: cardWidth)
        .frame(maxHeight: .infinity, alignment: .center)
        .background(Color(.systemBackground))
        .cornerRadius(16)
        .shadow(radius: 2)
    }
}
