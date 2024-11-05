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
    private let imageDimension = CGFloat(120)
    private let imageShape = RoundedRectangle(cornerRadius: GlobalConstants.cornerRadius)
    
    let didSelectProfile: (_ isAccepted: Bool) -> Void
    
    var body: some View {
        HStack(alignment: .center) {
            WebImage(url: URL(string: profile.imageUrl)) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: imageDimension, height: imageDimension)
                    .clipped()
            } placeholder: {
                Rectangle()
                    .foregroundColor(.orange.opacity(0.8))
                    .frame(width: imageDimension, height: imageDimension)
            }
            .clipShape(imageShape)
            .overlay(imageShape.stroke(Color.black, lineWidth: 1))

            VStack(alignment: .leading) {
                Text(profile.name)
                    .bold()
                    .multilineTextAlignment(.leading)
                    .font(.title3)
                    .foregroundStyle(.orange)
                
                Text(profile.address)
                    .multilineTextAlignment(.leading)
                
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
                        
                        CircularIconButton(systemName: "envelope", color: .black) {
                            if let url = URL(string: "mailto:\(profile.email)") {
                                UIApplication.shared.open(url)
                            }
                        }
                        
                    }
                }
                .padding()
            }
            .frame(maxWidth: .infinity, alignment: .topLeading)
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
