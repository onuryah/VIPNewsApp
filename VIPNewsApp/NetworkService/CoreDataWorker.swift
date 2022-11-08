//
//  CommonFunctions.swift
//  NewsApp
//
//  Created by admin on 5.11.2022.
//

import Foundation
import CoreData
import UIKit

protocol NewsFetcher {
    func retrieveValues(compilation: @escaping ([Article]) ->())
}
protocol NewsAdjuster {
    func save(name: String, title: String, urlToImage: String?, content: String?)
    func deleteData(name: String, title: String, urlToImage: String?, content: String?)
}

struct CoreDataWorker: NewsFetcher, NewsAdjuster {
    
    func retrieveValues(compilation: @escaping ([Article]) ->()){
        var favoritedNewsArray = [Article]()
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate{
            let context = appDelegate.persistentContainer.viewContext
            let fetchRequest = NSFetchRequest<Entity>(entityName: "Entity")
            fetchRequest.returnsObjectsAsFaults = false
            do{
                let results = try context.fetch(fetchRequest)
                for result in results as [NSManagedObject]{
                    let name = result.value(forKey: "name") as? String
                    let title = result.value(forKey: "title") as? String
                    let content = result.value(forKey: "content") as? String?
                    let urlToImage = result.value(forKey: "urlToImage") as? String?
                    
                    let favoritedNew = Article(source: Source(name: name!), title: title!, urlToImage: urlToImage ?? "", content: content ?? "")
                    favoritedNewsArray.append(favoritedNew)
                    compilation(favoritedNewsArray)
                }
            }catch{}
        }
    }
    
    func save(name: String, title: String, urlToImage: String?, content: String?){
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate{
            let context = appDelegate.persistentContainer.viewContext
            guard let entityDescription = NSEntityDescription.entity(forEntityName: "Entity", in: context)else{return}
            
            let newValue = NSManagedObject(entity: entityDescription, insertInto: context)
            newValue.setValue(name, forKey: "name")
            newValue.setValue(title, forKey: "title")
            newValue.setValue(urlToImage, forKey: "urlToImage")
            newValue.setValue(content, forKey: "content")
            do{
                try context.save()
            }catch{}
        }
    }
    
    func deleteData(name: String, title: String, urlToImage: String?, content: String?){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<Entity>(entityName: "Entity")
        fetchRequest.returnsObjectsAsFaults = false
        
        if let results = try? context.fetch(fetchRequest){
            if results.count > 0 {
                for result in results {
                    if result.name == name && result.title == title && result.urlToImage == urlToImage && result.content == content{
                        context.delete(result)
                    }
                    do {
                        try context.save()
                    } catch {}
                }
            }
        }
    }
}
