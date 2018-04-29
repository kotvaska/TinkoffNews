//
// Created by Anastasia Zolotykh on 29.04.2018.
// Copyright (c) 2018 kotvaska. All rights reserved.
//

import Foundation

struct Resource<T> {

    let url: URL
    let response: (Data) -> T?

}

struct News: Codable {

    let id: String
    let name: String
    let text: String
    let publicationDate: PublicationDate
    let content: String?

    init(id: String, name: String, text: String, publicationDate: PublicationDate, content: String) {
        self.id = id
        self.name = name
        self.text = text
        self.publicationDate = publicationDate
        self.content = content
    }

    init() {
        self.id = "0"
        self.name = ""
        self.text = ""
        self.publicationDate = PublicationDate(milliseconds: 0)
        self.content = ""
    }

}

struct PublicationDate: Codable {
    let milliseconds: TimeInterval
}
