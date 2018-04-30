//
// Created by Anastasia Zolotykh on 29.04.2018.
// Copyright (c) 2018 kotvaska. All rights reserved.
//

import Foundation

class NewsDetailPresenter: BasePresenter {

    typealias V = NewsDetailView
    var view: NewsDetailView! = nil
    var controllerTitle: String = "Описание новости"

    private var id: String!
    private var newsInteractor: NewsInteractor!

    required init(view: NewsDetailView) {
        self.view = view
    }

    convenience init(view: NewsDetailView, newsInteractor: NewsInteractor, id: String) {
        self.init(view: view)
        self.newsInteractor = newsInteractor
        self.id = id
    }

    func viewDidLoad() {
        view.startLoading()

        newsInteractor.getDetailNews(id: id) { [weak self] response, error in
            guard let strongSelf = self else {
                return
            }
            guard let response = response, error == nil else {
                strongSelf.view.alertError(message: error!.localizedDescription)
                return
            }

            strongSelf.view.setLabelContent(content: response.news.content?.htmlToAttributedString)
            strongSelf.view.finishLoading()
        }
    }

}
