//
// Created by Anastasia Zolotykh on 28.04.2018.
// Copyright (c) 2018 kotvaska. All rights reserved.
//

import Foundation

class UrlBuilder {

    let baseUrl: String

    init(baseUrl: String) {
        self.baseUrl = baseUrl
    }

    func newsList() -> URL {
        return URL(string: "\(baseUrl)/news")!
    }

    func newsDetail(id: String) -> URL {
        return URL(string: "\(baseUrl)/news_content?id=\(id)")!
    }

}
