//
//  HttpRequest.swift
//  PCHNetworkAPI
//
//  Created by Nahuel Zapata on 01/06/2018.
//  Copyright © 2018 PCH. All rights reserved.
//

import Alamofire
import Foundation

protocol HttpRequestable {
    var endpoint: Endpoint { get set }

    var params: [String: Any] { get set }

    var headers: [String: String] { get set }

    var method: HTTPMethod { get set }
}

struct HTTPRequest: HttpRequestable {
    var endpoint: Endpoint

    var method: HTTPMethod

    var params: [String: Any]

    var encoding: JSONEncoding

    var headers: [String: String]

    init(endpoint: Endpoint,
         httpMethod: HTTPMethod,
         parameters: [String: Any],
         encoding: JSONEncoding = JSONEncoding.default,
         headers: [String: String]) {
        self.endpoint = endpoint
        self.method = httpMethod
        self.params = parameters
        self.encoding = encoding
        self.headers = headers
    }
}
