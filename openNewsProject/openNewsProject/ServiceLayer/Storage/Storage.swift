//
//  CoreData.swift
//  openNewsProject
//
//  Created by Developer on 06.06.2022.
//

import Foundation
import UIKit
import CoreData

protocol Storable {
    func save(model: DetailViewModel)
    func fetchData() -> [DetailViewModel]
    func remove(id: Int)
}

class Storage: Storable {
    private var objects: [NSManagedObject] = []
    
    func save(model: DetailViewModel) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        let managedContext = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "NewsData", in: managedContext)!
        let newsData = NSManagedObject(entity: entity, insertInto: managedContext)
        
        newsData.setValue(model.id, forKey: "id")
        newsData.setValue(model.title, forKey: "title")
        newsData.setValue(model.url, forKey: "url")
        newsData.setValue(model.imagePath, forKey: "imagePath")
        newsData.setValue(model.publishedDate, forKey: "publishedDate")
        
        do {
            try managedContext.save()
            
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    func fetchData() -> [DetailViewModel] {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return []
        }
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "NewsData")
        
        do {
            objects = try managedContext.fetch(fetchRequest)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        var array = [DetailViewModel]()
        for object in objects {
            guard let id = object.value(forKey: "id") as? Int else { return []}
            guard let title = object.value(forKey: "title") as? String else { return []}
            guard let url = object.value(forKey: "url") as? String else { return []}
            let imagePath = object.value(forKey: "imagePath") as? String
            guard let publishedDate = object.value(forKey: "publishedDate") as? String else { return []}
            
            let newsObject: DetailViewModel = .init(
                id: id,
                title: title,
                url: url,
                imagePath: imagePath,
                publishedDate: publishedDate
            )
            array.append(newsObject)
        }
        return array
    }
    
    func remove(id: Int) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "NewsData")
        
        if let objects = try? managedContext.fetch(fetchRequest) {
            
            for object in objects {
                guard let objectId = object.value(forKey: "id") as? Int else { return }
                if objectId == id {
                    managedContext.delete(object)
                }
            }
            do {
                try managedContext.save()
            } catch {
                print("Error")
            }
        }
    }
}
