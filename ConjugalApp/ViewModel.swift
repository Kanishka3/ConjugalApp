//
//  ViewModel.swift
//  ConjugalApp
//
//  Created by Kanishka Chaudhry on 04/11/24.
//

import Foundation

class ViewModel: ObservableObject {
    
    var profiles = [Profile]()
    
    @Published var displayItems = [ProfileModel]()
    
    let persistanceManager = PersistanceManager()
    let networkMonitor = NetworkMonitor()
    
    func getProfiles() async {
        if networkMonitor.isConnected {
            await fetchProfiles()
        } else {
            await saveFromCache()
        }
    }
    
    func fetchProfiles() async {
        guard let url = URL(string: GlobalConstants.url) else { return }
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                profiles.removeAll()
                return
            }
            let decodedResponse = try JSONDecoder().decode(ResponseData.self, from: data)
            profiles = decodedResponse.results
            persistanceManager.saveProfile(profiles: profiles)
            await saveFromCache()
        } catch {
            profiles.removeAll()
        }
    }
    
    func changeStatus(for email: String, isAccepted: Bool) throws {
        try persistanceManager.updateProfileAcceptance(for: email, isAccepted: isAccepted)
    }
    
    private func saveFromCache() async {
        guard let res = persistanceManager.fetchProfiles() else { return }
        DispatchQueue.main.async {
            self.displayItems = res
            self.objectWillChange.send()
            print(self.displayItems)
        }
    }
}
