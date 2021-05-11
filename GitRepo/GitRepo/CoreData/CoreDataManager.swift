//
//  CoreDataManager.swift
//  GitRepo
//
//  Created by Islam Elgaafary on 11/05/2021.
//

import UIKit
import CoreData

class CoreDataManager{
    
    // MARK:- Properties
    public static var shared = CoreDataManager()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let privateMOC = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
    var repos = [RepoCore]()
    
    private init(){
        privateMOC.parent = context
    }
    
    
    // MARK:- Fetch Records
    func fetchRepos() {
        do {
            self.repos =  try context.fetch(RepoCore.fetchRequest())
        }
        catch let error {
            print("Fetch Records error :", error)
        }
    }
    
    
    // MARK:- Add Request
    public func addRequest(repo:RepositoryModel) {
        
        privateMOC.performAndWait {
            let newRepo = RepoCore(context: privateMOC)
            newRepo.id = Int16(repo.id ?? Int())
            newRepo.name = repo.name ?? ""
            newRepo.repoDesciption = repo.description ?? ""
            newRepo.ownerId = Int16(repo.owner?.id ?? Int())
            newRepo.ownerName = repo.owner?.login ?? ""
            newRepo.ownerAvatar = repo.owner?.avatarUrl ?? ""
            saveContext(forContext: privateMOC)
        }
        
        self.save()
    }

    
    // MARK:- Save Records
    func save() {
        do {
            try context.save()
        }
        catch let error {
            print("Save Records error :", error)
        }
        fetchRepos()
    }
    
    func saveContext(forContext context: NSManagedObjectContext) {
        if context.hasChanges {
            context.performAndWait{
                do {
                    try context.save()
                } catch {
                    let nserror = error as NSError
                    print("Error when saving !!! \(nserror.localizedDescription)")
                    print("Callstack :")
                    for symbol: String in Thread.callStackSymbols {
                        print(" > \(symbol)")
                    }
                }
            }
        }
    }
    
    // MARK:- Delete All Records
    public func deleteAllRepos() {
        fetchRepos()
        for object in self.repos {
            self.context.delete(object)
        }
        self.save()
    }
    
    
    // MARK:- Get Records
    func getRepos() -> [RepoCore] {
        fetchRepos()
        return repos
    }
    
}
