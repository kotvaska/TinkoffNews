//
// Created by Anastasia Zolotykh on 29.04.2018.
// Copyright (c) 2018 kotvaska. All rights reserved.
//

import Foundation

protocol NewsListView: BaseView {

    func hideRefreshLoader()

    func updateDataSource(news: [News])

    func openDetailNews(id: String)

}
