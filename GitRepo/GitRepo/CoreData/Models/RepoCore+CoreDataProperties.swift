//
//  RepoCore+CoreDataProperties.swift
//  
//
//  Created by Islam Elgaafary on 11/05/2021.
//
//

import Foundation
import CoreData


extension RepoCore {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<RepoCore> {
        return NSFetchRequest<RepoCore>(entityName: "RepoCore")
    }

    @NSManaged public var id: Int16
    @NSManaged public var name: String?
    @NSManaged public var repoDesciption: String?
    @NSManaged public var ownerId: Int16
    @NSManaged public var ownerName: String?
    @NSManaged public var ownerAvatar: String?

}
