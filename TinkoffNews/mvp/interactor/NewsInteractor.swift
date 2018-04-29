//
// Created by Anastasia Zolotykh on 29.04.2018.
// Copyright (c) 2018 kotvaska. All rights reserved.
//

import Foundation

class NewsInteractor {

    private unowned let dataStore: DataStoreUpdating
    private let networkClient: NetworkClient
    private let dbClient: DbClient
    private let modelSerializer: ModelSerializer

    typealias Completion = (Error?) -> ()

    init(dataStore: DataStoreUpdating, networkClient: NetworkClient, dbClient: DbClient, modelSerializer: ModelSerializer) {
        self.dataStore = dataStore
        self.networkClient = networkClient
        self.dbClient = dbClient
        self.modelSerializer = modelSerializer
    }

    func getNewsList(completion: Completion? = nil) {
        networkClient.updateNewsList() { [weak self] payload, error in
            guard let strongSelf = self,
                  error == nil,
                  let payload = payload?.payload,
                  let response: NewsListResponse = strongSelf.modelSerializer.deserializeToStruct(fromData: payload) else {
                completion?(error)
                return
            }

            DispatchQueue.main.async {
                strongSelf.dataStore.update(news: response.news)
                completion?(nil)
            }
        }
    }

    func getDetailNews(id: Int, completion: Completion? = nil) {
        networkClient.updateDetailNews(id: id) { [weak self] payload, error in
            guard let strongSelf = self,
                  error == nil,
                  let payload = payload?.payload,
                  let response: NewsDetailResponse = strongSelf.modelSerializer.deserializeToStruct(fromData: payload) else {
                completion?(error)
                return
            }
            DispatchQueue.main.async {
                strongSelf.dataStore.update(detailNews: response.news)
                completion?(nil)
            }
        }
    }

}
