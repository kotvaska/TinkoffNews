//
// Created by Anastasia Zolotykh on 28.04.2018.
// Copyright (c) 2018 kotvaska. All rights reserved.
//

import Foundation

protocol DataStoreObserver: class {
    func newsDidUpdate(news: [News])
    func detailNewsDidUpdate(detailNews: News)
}

protocol DataStoreProtocol: class {
    var news: [News] { get }
    var detailNews: News { get }
}

protocol DataStoreUpdating: class {
    func update(news: [News])
    func update(detailNews: News)
}
