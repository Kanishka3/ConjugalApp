//
//  ViewModel.swift
//  ConjugalApp
//
//  Created by Kanishka Chaudhry on 04/11/24.
//

import Foundation

class ViewModel: ObservableObject {
    
    private let baseUrl = "https://randomuser.me/api/?results=10"
    
    var profiles = [Profile]()
    
    @Published var displayItems = [ProfileModel]()
    
    let persistanceManager = PersistanceManager()
    let networkMonitor = NetworkMonitor()
    
    func getProfiles() async {
        if networkMonitor.isConnected {
            await fetchProfiles()
        } else {
            persistanceManager.fetchProfiles()
            await saveFromCache()
        }
    }
    
    func fetchProfiles() async {
        guard let url = URL(string: baseUrl) else { return }
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                profiles = []
                return
            }
            let decodedResponse = try JSONDecoder().decode(ResponseData.self, from: data)
            profiles = decodedResponse.results
            persistanceManager.saveProfile(profiles: profiles)
            await saveFromCache()
        } catch {
            profiles = []
        }
    }
    
    func changeStatus(for profile: Profile, isAccepted: Bool) throws {
        try persistanceManager.updateProfileAcceptance(for: profile.email, isAccepted: isAccepted)
        objectWillChange.send()
    }
    
    private func saveFromCache() async {
        guard let res = persistanceManager.fetchProfiles() else { return }
        await MainActor.run {
            displayItems = res
            print(displayItems)
        }
    }
}
