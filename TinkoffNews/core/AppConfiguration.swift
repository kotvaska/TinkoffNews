//
// Created by Anastasia Zolotykh on 28.04.2018.
// Copyright (c) 2018 kotvaska. All rights reserved.
//

import Foundation

class AppConfiguration {

    private let urlBuilder: UrlBuilder
    let networkClient: NetworkClient
    let modelSerializer: ModelSerializer
    let dbClient: DbClient
    let alertBuilder: AlertBuilder

    init() {
        alertBuilder = AlertBuilder()
        modelSerializer = ModelSerializer()
        dbClient = DbClient()

        let baseUrl = "https://api.tinkoff.ru/v1"
        urlBuilder = UrlBuilder(baseUrl: baseUrl)
        networkClient = NetworkClient(urlBuilder: urlBuilder, modelSerializer: modelSerializer)

    }

}
