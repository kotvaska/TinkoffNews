//
// Created by Anastasia Zolotykh on 28.04.2018.
// Copyright (c) 2018 kotvaska. All rights reserved.
//

import Foundation

class WebLoader {

    func load<T>(resource: Resource<T>, completion: @escaping (T?, Error?) -> ()) {
        URLSession.shared.dataTask(with: resource.url) { (data, _, error) in
            let result = data.flatMap(resource.response)
            completion(result, error)
        }.resume()
    }

}
