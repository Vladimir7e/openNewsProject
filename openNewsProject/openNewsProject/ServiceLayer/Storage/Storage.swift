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
    func save(model: DescriptionViewModel)
    func fetchData() -> [DescriptionViewModel]
    func remove(id: Int)
    func reorderItemsCoreData(sourceRow: Int, destinationRow: Int)
}

class Storage: Storable {
    private var objects: [NSManagedObject] = []
    
    func save(model: DescriptionViewModel) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        let managedContext = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "NewsData", in: managedContext)!
        let newsData = NSManagedObject(entity: entity, insertInto: managedContext)
        
        newsData.setValue(model.id, forKey: "id")
        newsData.setValue(model.title, forKey: "title")
        newsData.setValue(model.abstract, forKey: "abstract")
        newsData.setValue(model.url, forKey: "url")
        newsData.setValue(model.imagePath, forKey: "imagePath")
        newsData.setValue(model.publishedDate, forKey: "publishedDate")
        
        do {
            try managedContext.save()
            
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    func fetchData() -> [DescriptionViewModel] {
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
        var array = [DescriptionViewModel]()
        for object in objects {
            if let newsData: NewsData = object as? NewsData {
                let newsObject: DescriptionViewModel = .init(
                    id: Int(newsData.id),
                    title: newsData.title ?? "",
                    abstract: newsData.abstract ?? "",
                    url: newsData.url ?? "",
                    imagePath: newsData.imagePath,
                    publishedDate: newsData.publishedDate ?? ""
                )
                array.append(newsObject)
            }
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
    
    func reorderItemsCoreData(sourceRow: Int, destinationRow: Int) {
        var arr: [DescriptionViewModel] = fetchData()
        arr.forEach { model in
            remove(id: model.id)
        }
        
        let elementCoreData: DescriptionViewModel = arr.remove(at: sourceRow)
        arr.insert(elementCoreData, at: destinationRow)
        arr.forEach { model in
            save(model: model)
        }
    }
}
