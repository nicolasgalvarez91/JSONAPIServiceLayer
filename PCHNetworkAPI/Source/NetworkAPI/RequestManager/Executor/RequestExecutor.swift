//
//  RequestExecutor.swift
//  PCHNetworkAPI
//
//  Created by Nahuel Zapata on 01/06/2018.
//  Copyright © 2018 PCH. All rights reserved.
//

import Alamofire
import Foundation
import PromiseKit

protocol RequestExecutable {
    func execute<T: Decodable>(request: HttpRequestable, with expectedType: T.Type) -> HttpResponsable
}

class AlamofireRequestExecutor: RequestExecutable {
    let responseHandler: ResponseParseable

    init(responseHandler: ResponseParseable = AlamofireResponseParser()) {
        self.responseHandler = responseHandler
    }

    func execute<T: Decodable>(request: HttpRequestable, with expectedType: T.Type) -> HttpResponsable {
        return Promise<T> { seal in
            Alamofire.request(request.endpoint.buildURL(),
                              method: request.method,
                              parameters: request.params,
                              encoding: JSONEncoding.default,
                              headers: request.headers)
                .validate()
                .responseJSON { response in
                    do {
                        let parsedResponse = try self.responseHandler.handleResponse(response: response,
                                                                                     expectedType: T.self)
                        seal.fulfill(parsedResponse)
                    } catch {
                        NSLog(error.localizedDescription)
                        seal.reject(error)
                    }
            }
        }
    }
}
