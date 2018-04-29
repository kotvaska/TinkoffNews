//
// Created by Anastasia Zolotykh on 29.04.2018.
// Copyright (c) 2018 kotvaska. All rights reserved.
//

import Foundation

class NewsListPresenter: BasePresenter {

    typealias V = NewsListView
    var view: V!
    var controllerTitle: String = "Новости"

    private var newInteractor: NewsInteractor!

    required init(view: V) {
        self.view = view
    }

    convenience init(view: NewsListView, newInteractor: NewsInteractor) {
        self.init(view: view)
        self.newInteractor = newInteractor
    }

    func viewDidLoad() {
        newInteractor.getNewsList()
    }

}
