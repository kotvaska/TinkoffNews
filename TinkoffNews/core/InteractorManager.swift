//
// Created by Anastasia Zolotykh on 29.04.2018.
// Copyright (c) 2018 kotvaska. All rights reserved.
//

import Foundation

class InteractorManager {

    private let appConfiguration: AppConfiguration
    private unowned let dataStore: DataStoreUpdating

    init(appConfiguration: AppConfiguration, dataStore: DataStoreUpdating) {
        self.appConfiguration = appConfiguration
        self.dataStore = dataStore
    }

    func newNewsInteractor() -> NewsInteractor {
        return NewsInteractor(dataStore: dataStore, networkClient: appConfiguration.networkClient, dbClient: appConfiguration.dbClient, modelSerializer: appConfiguration.modelSerializer)
    }

}
