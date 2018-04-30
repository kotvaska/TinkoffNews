//
// Created by Anastasia Zolotykh on 30.04.2018.
// Copyright (c) 2018 kotvaska. All rights reserved.
//

import Foundation

typealias Completion<Response: Codable> = (Response?, Error?) -> ()

class NewsFacade {

    private let newsInteractor: NewsInteractor
    private let databaseInteractor: DatabaseInteractor

    init(newsInteractor: NewsInteractor, databaseInteractor: DatabaseInteractor) {
        self.newsInteractor = newsInteractor
        self.databaseInteractor = databaseInteractor
    }

    func getNewsList(completion: Completion<[News]>? = nil) {
        databaseInteractor.getNewsList() { [weak self] news, error in
            guard let strongSelf = self, let news = news, error == nil else {
                completion?(nil, error)
                return
            }

            if news.isEmpty {
                strongSelf.updateNewsList()
            } else {
                completion?(news, error)
            }
        }

    }

    func updateNewsList(completion: Completion<[News]>? = nil) {
        databaseInteractor.clearAllData() { [weak self] error in
            guard let strongSelf = self, error == nil else {
                completion?(nil, error)
                return
            }

            strongSelf.newsInteractor.getNewsList() { response, error in
                guard let response = response, error == nil else {
                    completion?(nil, error)
                    return
                }
                strongSelf.databaseInteractor.save(news: response.news, completion: nil)
                completion?(response.news, error)
            }
        }
    }

    func getDetailNews(id: String, completion: Completion<News>? = nil) {
        databaseInteractor.getDetailNews(id: id) { [weak self] news, error in
            guard let strongSelf = self else {
                completion?(nil, error)
                return
            }
            guard let news = news, let content = news.content, !content.isEmpty, error == nil else {
                strongSelf.newsInteractor.getDetailNews(id: id) { response, error in
                    strongSelf.databaseInteractor.update(news: response?.news ?? News(), completion: nil)
                    completion?(response?.news, error)
                }
                return
            }

            completion?(news, nil)
        }

    }

}
