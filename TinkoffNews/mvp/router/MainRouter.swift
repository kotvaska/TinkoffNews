//
// Created by Anastasia Zolotykh on 28.04.2018.
// Copyright (c) 2018 kotvaska. All rights reserved.
//

import Foundation
import UIKit

protocol Routing: class {
    func showNewsDetailViewController(id: String)
    func dismissNewsDetailViewController()
}

class MainRouter: Routing {

    let navigationController: UINavigationController

    let newsListViewController: NewsListViewController
    var newsDetailViewController: NewsDetailViewController!

    init() {
        newsListViewController = NewsListViewController()
        navigationController = UINavigationController(rootViewController: newsListViewController)
    }

    func showNewsDetailViewController(id: String) {
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
