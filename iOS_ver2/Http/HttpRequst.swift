//
//  HttpEroticTopic.swift
//  avnight
//
//  Copyright © 2020 com. All rights reserved.
//

import Foundation
import UIKit

class HttpRequst {

    static func urlRequest<T: Codable>(_ path: String, _ model: T.Type, result: @escaping (T?) -> ()) {
        let domain = "https://willywu0201.github.io/data/"
        if let url = URL(string: domain + path) {
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                if let error = error {
                    print("model: \(T.Type.self), error: \(error.localizedDescription)")
                } else if let response = response as? HTTPURLResponse, let jsondata = data {
                    print("model: \(T.Type.self), statusCode: \(response.statusCode)")
                    let decoder = JSONDecoder()
                    do {
                        let object = try decoder.decode(T.self, from: jsondata)
                        DispatchQueue.main.async {
                            result(object)
                        }
                    } catch {
                        DispatchQueue.main.async {
                            result(nil)
                        }
                    }
                }
            }.resume()
        } else {
            print("Invalid URL.")
        }
    }
}
