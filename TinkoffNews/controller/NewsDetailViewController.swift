//
// Created by Anastasia Zolotykh on 28.04.2018.
// Copyright (c) 2018 kotvaska. All rights reserved.
//

import UIKit

class NewsDetailViewController: BaseController<NewsDetailPresenter>, NewsDetailView {


    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    required init(id: Int) {
        super.init(nibName: "NewsDetailViewController", bundle: nil)

        setView(baseView: self)
        setPresenter(presenter: NewsDetailPresenter(view: self, newsInteractor: getInteractorManager().newNewsInteractor(), id: id))

    }
}
