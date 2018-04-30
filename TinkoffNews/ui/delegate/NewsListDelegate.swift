//
// Created by Anastasia Zolotykh on 29.04.2018.
// Copyright (c) 2018 kotvaska. All rights reserved.
//

import UIKit

protocol SelectCell {
    func onCellSelected(indexPath: IndexPath)
}

class NewsListDelegate: NSObject, UITableViewDelegate {

    let selectDelegate: SelectCell

    init(selectDelegate: SelectCell) {
        self.selectDelegate = selectDelegate
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectDelegate.onCellSelected(indexPath: indexPath)
        tableView.deselectRow(at: indexPath, animated: true)
    }

}
