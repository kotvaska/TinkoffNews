//
// Created by Anastasia Zolotykh on 29.04.2018.
// Copyright (c) 2018 kotvaska. All rights reserved.
//

import Foundation


class NewsObserver {

    private let dataStore: DataStoreProtocol

    init(dataStore: DataStoreProtocol) {
        self.dataStore = dataStore
    }
}


extension NewsObserver: DataStoreObserver {

    func newsDidUpdate(news: [News]) {

    }

    func detailNewsDidUpdate(detailNews: News) {
    }

}
