//
// Created by Anastasia Zolotykh on 29.04.2018.
// Copyright (c) 2018 kotvaska. All rights reserved.
//

import Foundation

class NewsListPresenter: BasePresenter {

    typealias V = NewsListView
    var view: V!
    var controllerTitle: String = "Новости"

    private var newsFacade: NewsFacade!
    private var news: [News] = []

    required init(view: V) {
        self.view = view
    }

    convenience init(view: NewsListView, newsFacade: NewsFacade) {
        self.init(view: view)
        self.newsFacade = newsFacade
    }

    func viewDidLoad() {
        view.startLoading()
        loadData() {
            self.view.finishLoading()
        }
    }

    private func loadData(completion: @escaping () -> ()) {
        newsFacade.getNewsList() { [weak self] models, error in
            guard let strongSelf = self else {
                return
            }
            guard let models = models, error == nil else {
                strongSelf.view.alertError(message: error!.localizedDescription)
                return
            }
            strongSelf.view.updateDataSource(news: models)
            completion()
        }
    }

    func refresh() {
        loadData() {
            self.view.hideRefreshLoader()
        }
    }

}

extension NewsListPresenter: SelectCell {

    func onCellSelected(indexPath: IndexPath) {
        view.openDetailNews(id: news[indexPath.row].id)
    }

}
