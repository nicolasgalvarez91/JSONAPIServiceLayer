//
//  Endpoint.swift
//  PCHNetworkAPI
//
//  Created by User on 5/31/18.
//  Copyright © 2018 PCH. All rights reserved.
//

import Foundation

protocol Endpoint {
    var baseUrl: String { get set }
    var path: String { get set }
}

extension Endpoint {
    var baseUrl: String {
        return "http://pch.com/API/"
    }

    func buildURL() -> String {
        return baseUrl + path
    }
}
