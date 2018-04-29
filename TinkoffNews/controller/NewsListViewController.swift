//
// Created by Anastasia Zolotykh on 28.04.2018.
// Copyright (c) 2018 kotvaska. All rights reserved.
//

import UIKit

class NewsListViewController: BaseController<NewsListPresenter>, NewsListView {

    @IBOutlet weak var tableView: UITableView!

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    required init() {
        super.init(nibName: "NewsListViewController", bundle: nil)

        setView(baseView: self)
        setPresenter(presenter: NewsListPresenter(view: self, newInteractor: getInteractorManager().newNewsInteractor()))

    }

    override func loadView() {
        super.loadView()


    }
}
