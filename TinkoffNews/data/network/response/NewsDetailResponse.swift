//
// Created by Anastasia Zolotykh on 29.04.2018.
// Copyright (c) 2018 kotvaska. All rights reserved.
//

import Foundation

struct NewsDetailResponse: Codable {

    var news: News

    private enum CodingKeys: String, CodingKey {
        case news = "payload"
    }

    private enum NewsCodingKeys: String, CodingKey {
        case title
        case content
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        let newsContainer = try container.nestedContainer(keyedBy: NewsCodingKeys.self, forKey: .news)
        news = try newsContainer.decode(News.self, forKey: .title)
        let content = try newsContainer.decode(String.self, forKey: .content)

        news.content = content
    }

}
