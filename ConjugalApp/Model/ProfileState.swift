//
//  ProfileState.swift
//  ConjugalApp
//
//  Created by Kanishka Chaudhry on 05/11/24.
//

import Foundation

enum State {
    case accepted, rejected, notDecided
    
    var isDecided: Bool {
        self == .accepted || self == .rejected
    }
    
    var title: String {
        switch self {
        case .accepted:
            return "😊 Accepted"
        case .rejected:
            return "❌ Rejected"
        default: return ""
        }
    }
}

extension ProfileModel {
    var state: State {
        switch (didSelect, didAccept) {
        case (true, true):
            return State.accepted
        case (true, false):
            return State.rejected
        default:
            return State.notDecided
        }
    }
}
