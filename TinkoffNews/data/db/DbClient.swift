//
// Created by Anastasia Zolotykh on 28.04.2018.
// Copyright (c) 2018 kotvaska. All rights reserved.
//

import CoreData

class DbClient {

    let appDelegate: AppDelegate

    init(appDelegate: AppDelegate) {
        self.appDelegate = appDelegate
    }

    func save(tableName: String, news: News, completion: @escaping (Error?) -> ()) {
        let managedContext = appDelegate.persistentContainer.viewContext
        guard var entity = NSEntityDescription.entity(forEntityName: tableName, in: managedContext) else {
            completion(DbError())
            return
        }

        let newsObject = NewsEntityMapped(entity: entity, insertInto: managedContext)
        newsObject.setValue(news.content, forKeyPath: NewsEntityMapped.contentFieldName)
        newsObject.setValue(news.text, forKeyPath: NewsEntityMapped.textFieldName)
        newsObject.setValue(news.publicationDate.milliseconds, forKeyPath: NewsEntityMapped.publicationMillisecondsFieldName)
        newsObject.setValue(news.id, forKeyPath: NewsEntityMapped.idFieldName)

        do {
            try managedContext.save()
            completion(nil)

        } catch let error as NSError {
            completion(error)

        }
    }

    func update(tableName: String, news: News, completion: @escaping (Error?) -> ()) {
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: tableName)
        fetchRequest.predicate = NSPredicate(format: "\(NewsEntityMapped.idFieldName) like %@", argumentArray: [news.id])

        do {
            let newsObject = try managedContext.fetch(fetchRequest).first!
            newsObject.setValue(news.content, forKeyPath: NewsEntityMapped.contentFieldName)
            try managedContext.save()
            completion(nil)

        } catch let error as NSError {
            completion(error)
        }
    }

    func fetchList(tableName: String, completion: @escaping ([NSManagedObject], Error?) -> ()) {
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: tableName)

        do {
            let news = try managedContext.fetch(fetchRequest)
            completion(news, nil)

        } catch let error as NSError {
            completion([], error)

        }
    }

    func fetchItem(tableName: String, id: String, completion: @escaping (NSManagedObject?, Error?) -> ()) {
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: tableName)
        fetchRequest.predicate = NSPredicate(format: "\(NewsEntityMapped.idFieldName) like %@", argumentArray: [id])
        fetchRequest.fetchLimit = 1

        do {
            let news = try managedContext.fetch(fetchRequest).first
            completion(news, nil)

        } catch let error as NSError {
            completion(nil, error)

        }
    }

    func clearAllData(tableName: String, completion: @escaping (Error?) -> ()) {
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: tableName)

        do {
            let news = try managedContext.fetch(fetchRequest)
            news.forEach {
                managedContext.delete($0)
            }
            completion(nil)

        } catch let error as NSError {
            completion(error)

        }
    }

}
