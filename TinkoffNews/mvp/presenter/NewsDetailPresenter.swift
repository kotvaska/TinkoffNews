//
// Created by Anastasia Zolotykh on 29.04.2018.
// Copyright (c) 2018 kotvaska. All rights reserved.
//

import Foundation

class NewsDetailPresenter: BasePresenter {

    typealias V = NewsDetailView
    var view: NewsDetailView! = nil
    var controllerTitle: String = ""

    private var id: Int!
    private var newsInteractor: NewsInteractor!

    required init(view: NewsDetailView) {
        self.view = view
    }

    convenience init(view: NewsDetailView, newsInteractor: NewsInteractor, id: Int) {
        self.init(view: view)
        self.newsInteractor = newsInteractor
        self.id = id
    }

}
