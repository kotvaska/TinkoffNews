//
// Created by Anastasia Zolotykh on 29.04.2018.
// Copyright (c) 2018 kotvaska. All rights reserved.
//

import Foundation

class NewsListPresenter: BasePresenter {

    typealias V = NewsListView
    var view: V!
    var controllerTitle: String = "Новости"

    private var newsInteractor: NewsInteractor!
    private var news: [News] = []

    required init(view: V) {
        self.view = view
    }

    convenience init(view: NewsListView, newsInteractor: NewsInteractor) {
        self.init(view: view)
        self.newsInteractor = newsInteractor
    }

    func viewDidLoad() {
        view.startLoading()
        loadData() {
            self.view.finishLoading()
        }
    }

    private func loadData(completion: @escaping () -> ()) {
        newsInteractor.getNewsList() { [weak self] response, error in
            guard let strongSelf = self else {
                return
            }
            guard let response = response, error == nil else {
                strongSelf.view.alertError(message: error!.localizedDescription)
                return
            }
            strongSelf.news = response.news
            strongSelf.view.updateDataSource(news: response.news)
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