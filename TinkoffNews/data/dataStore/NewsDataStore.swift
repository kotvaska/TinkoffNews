//
// Created by Anastasia Zolotykh on 29.04.2018.
// Copyright (c) 2018 kotvaska. All rights reserved.
//

import Foundation

class NewsDataStore: DataStoreProtocol, DataStoreUpdating {

    private(set) var news: [News]
    private(set) var detailNews: News
    weak var observer: DataStoreObserver!

    init() {
        self.news = []
        self.detailNews = News()
    }

    func update(news: [News]) {
        self.news = news
        observer.newsDidUpdate(news: self.news)
    }

    func update(detailNews: News) {
        self.detailNews = detailNews
        observer.detailNewsDidUpdate(detailNews: self.detailNews)
    }

}
