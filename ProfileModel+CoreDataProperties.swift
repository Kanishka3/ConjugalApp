//
//  ProfileModel+CoreDataProperties.swift
//  ConjugalApp
//
//  Created by Kanishka Chaudhry on 05/11/24.
//
//

import Foundation
import CoreData


extension ProfileModel {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ProfileModel> {
        return NSFetchRequest<ProfileModel>(entityName: "ProfileModel")
    }

    @NSManaged public var name: String
    @NSManaged public var address: String
    @NSManaged public var email: String
    @NSManaged public var imageUrl: String
    @NSManaged public var didAccept: Bool
    @NSManaged public var didSelect: Bool

}

extension ProfileModel : Identifiable {

}
