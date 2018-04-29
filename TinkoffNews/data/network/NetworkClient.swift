//
// Created by Anastasia Zolotykh on 28.04.2018.
// Copyright (c) 2018 kotvaska. All rights reserved.
//

import Foundation

class NetworkClient {

    private let webService: WebLoader
    private let urlBuilder: UrlBuilder
    private let modelSerializer: ModelSerializer

    init(urlBuilder: UrlBuilder, modelSerializer: ModelSerializer) {
        self.urlBuilder = urlBuilder
        webService = WebLoader()
        self.modelSerializer = modelSerializer
    }

    private func getPayload(url: URL) -> Resource<BaseResponse> {
        return Resource<BaseResponse>(url: url) { [unowned self] data in
            var model: BaseResponse? = self.modelSerializer.deserializeToStruct(fromData: data)
            model?.payload = data
            return model
        }
    }

    func updateNewsList(completion: @escaping (BaseResponse?, Error?) -> ()) {
        webService.load(resource: getPayload(url: urlBuilder.newsList()), completion: completion)
    }

    func updateDetailNews(id: Int, completion: @escaping (BaseResponse?, Error?) -> ()) {
        webService.load(resource: getPayload(url: urlBuilder.newsDetail(id: String(id))), completion: completion)
    }

}
