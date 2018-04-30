//
// Created by Anastasia Zolotykh on 30.04.2018.
// Copyright (c) 2018 kotvaska. All rights reserved.
//

import CoreData

class NewsEntityMapped: NSManagedObject {

    static let tableName = "NewsEntity"
    static let textFieldName = "text"
    static let publicationMillisecondsFieldName = "publicationMilliseconds"
    static let idFieldName = "id"
    static let contentFieldName = "content"

}
