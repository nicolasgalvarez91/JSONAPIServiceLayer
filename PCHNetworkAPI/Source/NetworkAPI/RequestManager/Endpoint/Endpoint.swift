//
//  Endpoint.swift
//  PCHNetworkAPI
//
//  Created by User on 5/31/18.
//  Copyright © 2018 PCH. All rights reserved.
//

import Foundation

protocol Endpoint {
    var baseUrl: String { get }

    var path: String { get }

    func buildURL() -> String
}

extension Endpoint {
    var baseUrl: String {
        return "https://jsonplaceholder.typicode.com"
    }

    func buildURL() -> String {
        return baseUrl + path
    }
}
