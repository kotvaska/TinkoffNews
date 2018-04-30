//
// Created by Anastasia Zolotykh on 29.04.2018.
// Copyright (c) 2018 kotvaska. All rights reserved.
//

import Foundation

class NewsInteractor {

    private let networkClient: NetworkClient
    private let dbClient: DbClient
    private let modelSerializer: ModelSerializer

    typealias Completion<Response: Codable> = (Response?, Error?) -> ()

    init(networkClient: NetworkClient, dbClient: DbClient, modelSerializer: ModelSerializer) {
        self.networkClient = networkClient
        self.dbClient = dbClient
        self.modelSerializer = modelSerializer
    }

    func getNewsList(completion: Completion<NewsListResponse>? = nil) {
        // TODO: check cache
        networkClient.updateNewsList() { [weak self] payload, error in
            guard let strongSelf = self,
                  error == nil,
                  let payload = payload?.payload,
                  let response: NewsListResponse = strongSelf.modelSerializer.deserializeToStruct(fromData: payload) else {
                completion?(nil, error)
                return
            }

            // TODO: Save content
            DispatchQueue.main.async {
                completion?(response, nil)
            }
        }
    }

    func getDetailNews(id: String, completion: Completion<NewsDetailResponse>? = nil) {
        // TODO: check cache
        networkClient.updateDetailNews(id: id) { [weak self] payload, error in
            guard let strongSelf = self,
                  error == nil,
                  let payload = payload?.payload,
                  let response: NewsDetailResponse = strongSelf.modelSerializer.deserializeToStruct(fromData: payload) else {
                completion?(nil, error)
                return
            }

            // TODO: Save/update content
            DispatchQueue.main.async {
                completion?(response, nil)
            }
        }
    }

}
