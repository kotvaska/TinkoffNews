//
// Created by Anastasia Zolotykh on 29.04.2018.
// Copyright (c) 2018 kotvaska. All rights reserved.
//

import UIKit

class NewsListDataSource: NSObject, UITableViewDataSource {

    var news: [News]

    override init() {
        news = []
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return news.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NewsListItemCell.CELL_ID, for: indexPath) as! NewsListItemCell
        let model: News = news[indexPath.row]

        cell.titleLabel.text = model.text

        let date = Date(timeIntervalSince1970: model.publicationDate.seconds)
        let f = DateFormatter()
        f.dateFormat = "dd MMM yyyy HH:mm"
        cell.dateLabel.text = f.string(from: date)

        return cell
    }

}
