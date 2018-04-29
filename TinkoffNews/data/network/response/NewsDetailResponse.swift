//
// Created by Anastasia Zolotykh on 29.04.2018.
// Copyright (c) 2018 kotvaska. All rights reserved.
//

import Foundation

struct NewsDetailResponse: Codable {

    let news: News

    private enum CodingKeys: String, CodingKey {
        case news = "payload"
    }

}
