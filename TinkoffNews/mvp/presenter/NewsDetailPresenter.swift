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
    private var newsFacade: NewsFacade!

    required init(view: NewsDetailView) {
        self.view = view
    }

    convenience init(view: NewsDetailView, newsFacade: NewsFacade, id: String) {
        self.init(view: view)
        self.newsFacade = newsFacade
        self.id = id
    }

    func viewDidLoad() {
        view.startLoading()

        newsFacade.getDetailNews(id: id) { [weak self] model, error in
            guard let strongSelf = self else {
                return
            }
            guard let model = model, error == nil else {
                strongSelf.view.alertError(message: error!.localizedDescription)
                return
            }

            strongSelf.view.setLabelContent(content: model.content?.htmlToAttributedString)
            strongSelf.view.finishLoading()
        }
    }

}
