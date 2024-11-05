//
//  PersistanceManager.swift
//  ConjugalApp
//
//  Created by Kanishka Chaudhry on 05/11/24.
//

import Foundation
import CoreData

class PersistanceManager: ObservableObject {
    
    private let container: NSPersistentContainer
    
    @Published var savedEntities = [ProfileModel]()
    
    
    var viewContext: NSManagedObjectContext {
        return container.viewContext
    }
    
    init() {
        self.container = NSPersistentContainer(name: "DataContainer")
        container.loadPersistentStores { descrip, error in
            if let error {
                // show toast for error
            }
        }
    }
    
    @discardableResult
    func fetchProfiles() -> [ProfileModel]? {
        let request = NSFetchRequest<ProfileModel>(entityName: "ProfileModel")
        request.returnsObjectsAsFaults = false
        do {
            savedEntities = try viewContext.fetch(request)
            return savedEntities
        } catch {
            print("ERROR: Cant fetch")
        }
        return nil 
    }
    
    func saveContext() {
           do {
               try viewContext.save()
           } catch {
               viewContext.rollback()
               print(error.localizedDescription)
           }
       }
    
    func saveProfile(profiles: [Profile]) {
        removeAllProfiles()
        transform(profiles)
        saveContext()
    }
    
    func removeAllProfiles() {
        guard let profiles = fetchProfiles() else { return }
        for profile in profiles {
            viewContext.delete(profile)
        }
        saveContext()
    }
    
    func transform(_ collection: [Profile]) -> [ProfileModel] {
        var result = [ProfileModel]()
        collection.forEach { profile in
            let itemToAdd = ProfileModel(context: container.viewContext)
            itemToAdd.address = profile.displayAddress
            itemToAdd.name = profile.displayName
            itemToAdd.email = profile.email
            itemToAdd.imageUrl = profile.picture.medium
            result.append(itemToAdd)
        }
        return result
    }
    
    func updateProfileAcceptance(for email: String, isAccepted: Bool) throws {
        let request = NSFetchRequest<ProfileModel>(entityName: "ProfileModel")
        request.predicate = NSPredicate(format: "email == %@", email)
        do {
            let profiles = try viewContext.fetch(request)
            if let profileToUpdate = profiles.first {
                profileToUpdate.didAccept = isAccepted
                profileToUpdate.didSelect = true
                try viewContext.save()
            } else { //TODO: Can handle this case too
                print("ERROR: No user with this email found")
            }
        } catch let error {
            throw error
        }
    }
}
