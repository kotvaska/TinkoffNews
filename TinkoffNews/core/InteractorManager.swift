//
// Created by Anastasia Zolotykh on 29.04.2018.
// Copyright (c) 2018 kotvaska. All rights reserved.
//

import Foundation

class InteractorManager {

    private let appConfiguration: AppConfiguration

    init(appConfiguration: AppConfiguration) {
        self.appConfiguration = appConfiguration
    }

    func newNewsInteractor() -> NewsInteractor {
        return NewsInteractor(networkClient: appConfiguration.networkClient, modelSerializer: appConfiguration.modelSerializer)
    }

    func newDatabaseInteractor() -> DatabaseInteractor {
        return DatabaseInteractor(dbClient: appConfiguration.dbClient)
    }

    func newNewsFacade() -> NewsFacade {
        return NewsFacade(newsInteractor: newNewsInteractor(), databaseInteractor: newDatabaseInteractor())
    }

}
