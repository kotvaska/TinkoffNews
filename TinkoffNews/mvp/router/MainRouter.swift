//
// Created by Anastasia Zolotykh on 28.04.2018.
// Copyright (c) 2018 kotvaska. All rights reserved.
//

import Foundation
import UIKit

protocol Routing: class {
    func showNewsDetailViewController(id: Int)
    func dismissNewsDetailViewController()
}

class MainRouter: Routing {

    let navigationController: UINavigationController

    let newsListViewController: NewsListViewController
    var newsDetailViewController: NewsDetailViewController!

    unowned let dataObserver: NewsObserver

    init(dataObserver: NewsObserver) {
        self.dataObserver = dataObserver
        newsListViewController = NewsListViewController()
        navigationController = UINavigationController(rootViewController: newsListViewController)
    }

    func showNewsDetailViewController(id: Int) {
        newsDetailViewController = NewsDetailViewController(id: id)
        navigationController.pushViewController(newsDetailViewController, animated: true)
    }

    func dismissNewsDetailViewController() {
        navigationController.popViewController(animated: true)
    }

    func presentAlert(in controller: UIViewController, alertController: UIAlertController) {
        controller.present(alertController, animated: true)
    }

}
