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
