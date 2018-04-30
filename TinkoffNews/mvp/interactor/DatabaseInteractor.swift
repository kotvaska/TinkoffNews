//
// Created by Anastasia Zolotykh on 30.04.2018.
// Copyright (c) 2018 kotvaska. All rights reserved.
//

import Foundation

class DatabaseInteractor {

    private let dbClient: DbClient

    init(dbClient: DbClient) {
        self.dbClient = dbClient
    }

    func getNewsList(completion: Completion<[News]>? = nil) {
        dbClient.fetchList(tableName: NewsEntityMapped.tableName) { entites, error in
            guard error == nil else {
                completion?(nil, error)
                return
            }

            let news = entites.flatMap { entity in
                News(id: entity.value(forKey: NewsEntityMapped.idFieldName) as! String,
                        name: "",
                        text: entity.value(forKey: NewsEntityMapped.textFieldName) as! String,
                        publicationDate: PublicationDate(milliseconds: entity.value(forKey: NewsEntityMapped.publicationMillisecondsFieldName) as! TimeInterval),
                        content: (entity.value(forKey: NewsEntityMapped.contentFieldName) as? String) ?? "")
            }
            completion?(news, nil)

        }
    }

    func getDetailNews(id: String, completion: Completion<News>? = nil) {
        dbClient.fetchItem(tableName: NewsEntityMapped.tableName, id: id) { entity, error in
            guard let entity = entity, error == nil else {
                completion?(nil, error)
                return
            }

            let news = News(id: entity.value(forKey: NewsEntityMapped.idFieldName) as! String,
                    name: "",
                    text: entity.value(forKey: NewsEntityMapped.textFieldName) as! String,
                    publicationDate: PublicationDate(milliseconds: entity.value(forKey: NewsEntityMapped.publicationMillisecondsFieldName) as! TimeInterval),
                    content: (entity.value(forKey: NewsEntityMapped.contentFieldName) as? String) ?? "")
            completion?(news, nil)
        }
    }

    func save(news: [News], completion: ((Error?) -> ())?) {
        news.forEach {
            save(news: $0, completion: completion)
        }
    }

    private func save(news: News, completion: ((Error?) -> ())?) {
        dbClient.save(tableName: NewsEntityMapped.tableName, news: news, completion: { e in completion?(e) })
    }

    func update(news: News, completion: ((Error?) -> ())?) {
        dbClient.update(tableName: NewsEntityMapped.tableName, news: news, completion: { e in completion?(e) })
    }

    func clearAllData(completion: @escaping (Error?) -> ()) {
        dbClient.clearAllData(tableName: NewsEntityMapped.tableName, completion: completion)
    }

}
